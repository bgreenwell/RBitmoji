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
#' my_id <- get_id("username@@gmail.com")
#' plot_comic(ny_id, tag = "edvard")
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

  # If log in not successful, stop and provide message
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
