RBitmoji: An R wrapper to the overly complicated Bitmoji API <img src="https://render.bitstrips.com/v2/cpanel/8fc50cb6-a2c5-4996-94d8-a8462cf5b66e-8b06e67b-d4e9-4f11-a355-f1236df17079-v1.png?transparent=1&palette=1" width="200" height="200" align="right" />
=================================================================================================================================================================================================================================================================

Ya, this is happening...

⚠️ **WARNING:** This package is under constuction and not very useable at the moment. Help getting it up and running is greatly appreciated, especially since Bitmoji's are critical to data science...

📝 **TODO:**

1.  Figure out how to incorporate (the apparently missing) background images

2.  Figure out a better way to determine your unique user ID

3.  Switch to using [`httr`](https://cran.r-project.org/package=httr) and [`jsonlite`](https://cran.r-project.org/package=jsonlite)

Basic (and I mean basic) usage
------------------------------

``` r
# Load required packages
if (!requireNamespace("magick")) {
  install.packages("magick")
}
library(magick)

# Construct URL
base <- "https://render.bitstrips.com/v2/cpanel"  # base URL
template_id <- "15401"  # not sure about this, yet
comic_id <- "10228164"  # Edvard Munch's "The Scream"
user_id <- "128256895_1-s1-v1"  # blank male
extra <- "?transparent=1&palette=1"  # not sure about this, yet

# Plot Bitmoji
img <- image_read(paste0(base, "/", comic_id, "-", user_id, ".png"))
plot(as.raster(img))
```

<img src="tools/README-unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Inspirations
------------

-   <https://github.com/JoshCheek/bitmoji>

-   <https://github.com/matthewnau/randmoji>

-   <https://github.com/hadley/emo>
