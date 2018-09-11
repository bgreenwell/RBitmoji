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
