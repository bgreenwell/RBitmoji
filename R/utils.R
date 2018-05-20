#' Get comic IDs from tag
#'
#' Use a JSON file to look up all comic IDs associated with a given tag.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @export
#'
#' @examples
#' get_comic_ids("birthday")
#' get_comic_ids("edvard munch")  # Edvard Munch's "The Scream"
get_comic_ids <- function(tag) {
  # comics <- jsonlite::fromJSON("inst/json/comics.json")
  comics$imoji$comic_id[which(grepl(tag, comics$imoji$tags))]
}


#' Get comic ID from tag
#'
#' Use a JSON file to look up a comic ID associated with a given tag.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @export
#'
#' @examples
#' get_comic_id("birthday")
#' get_comic_id("edvard")  # Edvard Munch's "The Scream"
get_comic_id <- function(tag) {
  id <- get_comic_ids(tag)
  if (length(id) > 1) {
    sample(id, size = 1)
  } else {
    id
  }
}


#' Get Bitmoji comic
#'
#' Get a Bitmoji comic.
#'
#' @param id Character string specifying the users unique ID.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @export
#'
#' @examples
#' get_comic("8b06e67b-d4e9-4f11-a355-f1236df17079-v1", tag = "edvard")
get_comic <- function(id, tag) {
  comic_id <- get_comic_id(tag)
  base <- "https://render.bitstrips.com/v2/cpanel"  # base URL
  url <- paste0(base, "/", comic_id, "-", id, ".png")
  magick::image_read(url)
}


#' Plot Bitmoji comic
#'
#' Plot a Bitmoji comic.
#'
#' @param id Character string specifying the users unique ID.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @export
#'
#' @examples
#' # ID obtained using get_id()
#' plot_comic("8b06e67b-d4e9-4f11-a355-f1236df17079-v1", tag = "edvard")
plot_comic <- function(id, tag) {
  img <- get_comic(id, tag)
  # usr <- par()
  par(mar = c(0, 0, 0, 0) + 0.1)
  plot(as.raster(img))
}

#' Get user id
#'
#' Get unique user id for use with \code{\link{plot_comic}} and
#' \code{\link{get_comic}}.
#'
#' @param user_email Character string specifying the email associated with the
#' Bitmoji account for which you'd like to get/plot comics (e.g.,
#' \code{username@@gmail.com}).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' id <- get_id("username@@gmail.com")
#' plot_comic(id, tag = "edvard")
#' }
get_id <- function(user_email) {

  # Attempt to log in
  login_url = 'https://api.bitmoji.com/user/login'
  login_response <- httr::POST(
    url = login_url,
    httr::add_headers(
      Accept = "application/json",
      "Accept-Encoding" = "gzip, deflate, br",
      "Accept-Language" = "en-US,en;q=0.9",
      Connection = "keep-alive",
      "Content-Type" = "application/x-www-form-urlencoded",
      Host = "api.bitmoji.com",
      Origin = "https://www.bitmoji.com",
      Referer = "https://www.bitmoji.com/account_v2/"
    ),
    body = list(
      client_id = "imoji",
      username = user_email,
      password = getPass::getPass(
        msg = "Enter the password for your Bitmoji account:"
      ),
      grant_type = "password",
      client_secret = "secret"
    ),
    encode = "form"
  )

  # If log in not successful login, stop and provide message
  if(login_response$status_code != 200) {
    if("message" %in% names(httr::content(login_response))) {
      stop(httr::content(login_response)$message)
    } else {
      stop(httr::content(login_response)$error)
    }
  }

  # If log in successful, extract token
  token <- httr::content(login_response)$access_token

  # Fetch user ID
  avatar_url <- "https://api.bitmoji.com/user/avatar"
  avatar_response <- httr::GET(
    url = avatar_url,
    httr::add_headers(
      "Accept-Encoding" = "gzip, deflate, br",
      "Accept-Language" = "en-US,en;q=0.9",
      "bitmoji-token" = token,
      Connection = "keep-alive",
      "Content-Type" = "application/x-www-form-urlencoded",
      Host = "api.bitmoji.com",
      Origin = "https://www.bitmoji.com",
      Referer = "https://www.bitmoji.com/account_v2/"
    )
  )

  # Stop if request fails
  if(avatar_response$status_code != 200) {
    stop(httr::content(login_response)$error, call. = FALSE)
  }

  # extract id if successful avatar_response
  uid <- httr::content(avatar_response)$avatar_version_uuid

  # Attempt to log out
  logout_url <- "https://api.bitmoji.com/user/logout"
  logout_response <- httr::POST(
    url = logout_url,
    httr::add_headers(
      Accept = "application/json",
      "Accept-Encoding" = "gzip, deflate, br",
      "Accept-Language" = "en-US,en;q=0.9",
      "bitmoji-token" = token,
      Connection = "keep-alive",
      "Content-Type" = "application/x-www-form-urlencoded",
      Host = "api.bitmoji.com",
      Origin = "https://www.bitmoji.com",
      Referer = "https://www.bitmoji.com/account_v2/"
    )
  )

  # Return user ID
  paste0(uid, "-v1")  # FIXME: Is this always needed?

}
