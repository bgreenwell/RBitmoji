comics <- jsonlite::fromJSON("data-raw/comics.json")
devtools::use_data(comics, internal = TRUE)
