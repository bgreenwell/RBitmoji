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
#' get_imoji_comic_ids("birthday")
#' get_imoji_comic_ids("edvard munch")  # Edvard Munch's "The Scream"
get_imoji_comic_ids <- function(tag) {
  comics$imoji$comic_id[which(grepl(tag, comics$imoji$tags))]
}


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
#' get_friends_comic_ids("birthday")
#' get_friends_comic_ids("edvard munch")  # Edvard Munch's "The Scream"
get_friends_comic_ids <- function(tag) {
  comics$friends$comic_id[which(grepl(tag, comics$friends$tags))]
}


#' Get comic ID from tag
#'
#' Use a JSON file to look up a comic ID associated with a given tag.
#'
#' @param tag Character string specifying the keyword tag (e.g.,
#' \code{"birthday"}).
#'
#' @param friends Logical indicating whether or not to find a friends comic.
#' Default is \code{FALSE}.
#'
#' @export
#'
#' @examples
#' get_comic_id("birthday")
#' get_comic_id("birthday", friends = TRUE)
#' get_comic_id("edvard")  # Edvard Munch's "The Scream"
get_comic_id <- function(tag, friends = FALSE) {
  id <- if (friends) {
    get_friends_comic_ids(tag)
  } else {
    get_imoji_comic_ids(tag)
  }
  if (length(id) > 1) {
    sample(id, size = 1)
  } else {
    id
  }
}
