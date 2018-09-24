# RBitmoji: An R wrapper to the overly complicated Bitmoji API <img src="tools/RBitmoji-logo.png" align="right" width="130" height="150" />

[![Travis-CI Build
Status](https://travis-ci.org/bgreenwell/RBitmoji.svg?branch=master)](https://travis-ci.org/bgreenwell/RBitmoji)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/bgreenwell/RBitmoji?branch=master&svg=true)](https://ci.appveyor.com/project/bgreenwell/RBitmoji)

Ya, this is happening…

## Update

You can now plot with friends\!

``` r
# Use get_id() to find your unique user ID
my_id <- "1551b314-5e8a-4477-aca2-088c05963111-v1"
RBitmoji::plot_comic(c(my_id, my_id), tag = "boom")
```

<img src="tools/README-unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

## Installation

You can (try to) install the development version of `RBitmoji` grom
GitHub using

``` r
if (!requireNamespace("devtools")) {
  install.packages("devtools")
}
devtools::install_github("bgreenwell/RBitmoji")
```

## Obtaining your Bitmoji ID

In order to use `RBitmoji` you will need your unique Bitmoji ID, which
can be difficult to find. Fortunately, the `get_id()` function can
simplify the process\! TO use this function, you must supply the email
address associated with your Bitmoji account. You will then be prompted
to enter your Bitmoji account password using a secure blah, blah, blah.
For example:

``` r
library(RBitmoji)
my_id <- get_id("greenwell.brandon@gmail.com")
```

If successful, your id will be stored in the variable `my_id`. Once that
is done, you can use the `plot_comic()` function to do real data
science.

## Basic (and I mean basic) usage

``` r
# Some tags correspond to multiple comics, so use set.seed()
set.seed(101)  # for reproducibility
my_id <- "1551b314-5e8a-4477-aca2-088c05963111-v1"
plot_comic(my_id, tag = "fail")
```

<img src="tools/README-unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

``` r

# Another example
plot_comic(my_id, tag = "time magazine")
```

<img src="tools/README-unnamed-chunk-3-2.png" style="display: block; margin: auto;" />

``` r

# Some tags are associated with multiple comics
par(mfrow = c(2, 2))
for (i in 1:4) plot_comic(my_id, tag = "cool")
```

<img src="tools/README-unnamed-chunk-3-3.png" style="display: block; margin: auto;" />

## Inspirations

  - <https://github.com/JoshCheek/bitmoji>

  - <https://github.com/matthewnau/randmoji>

  - <https://github.com/hadley/emo>
