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
#' @param comic_id Character string specifying the comic id (e.g.,
#' \code{"10228108"}).
#'
#' @param transparent Logical indicating whether or not the background should be
#' transparent. Default is \code{FALSE} (i.e., the background will be white).
#'
#' @export
#'
#' @examples
#' # ID obtained using get_id()
#' my_id <- "1551b314-5e8a-4477-aca2-088c05963111-v1"
#' get_comic(my_id, tag = "edvard")
#' get_comic(c(my_id, my_id), tag = "edvard")
#' get_comic(my_id, comic_id = "10224100")
get_comic <- function(id, tag = NULL, comic_id = NULL, transparent = FALSE) {
  friends <- length(id) > 1
  if(is.null(tag) & is.null(comic_id)){
    stop("Must specify either `tag` or `comic_id`.", call. = FALSE)
  } else if(!is.null(tag) & !is.null(comic_id)){
    stop("Must specify either `tag` or `comic_id`, but not both.",
         call. = FALSE)
  } else if(!is.null(tag)){
    comic_id <- get_comic_id(tag, friends = friends)
  }
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
  if (transparent) {
    url <- paste0(url, "?transparent=1")
  }
  # magick::image_read(url)
  png::readPNG(RCurl::getURLContent(url))
}
