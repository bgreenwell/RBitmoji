#' Get Bitmoji comic
#'
#' Get a Bitmoji comic.
#'
#' @param id Character string specifying the users unique ID. Can also be a
#' vector of length 2.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @export
#'
#' @examples
#' # ID obtained using get_id()
#' my_id <- "1551b314-5e8a-4477-aca2-088c05963111-v1"
#' get_comic(my_id, tag = "edvard")
#' get_comic(c(my_id, my_id), tag = "edvard")
get_comic <- function(id, tag) {
  friends <- length(id) > 1
  comic_id <- get_comic_id(tag, friends = friends)
  base <- "https://render.bitstrips.com/v2/cpanel"  # base URL
  if (length(id) > 1) {
    if (length(id == 2)) {
      id[1L] <- gsub("-v[0-9]$", replacement = "", x = id[1L])
      id <- paste(id, collapse = "-")
    } else {
      stop("`id` cannot contain more than 2 values.")
    }
  }
  url <- paste0(base, "/", comic_id, "-", id, ".png")
  # magick::image_read(url)
  png::readPNG(RCurl::getURLContent(url))
}
