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
