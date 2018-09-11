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
