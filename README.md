# RBitmoji: An R wrapper to the overly complicated Bitmoji API <img src="tools/RBitmoji-logo.png" align="right" width="130" height="150" />

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/RBitmoji)](https://cran.r-project.org/package=RBitmoji)
[![Travis-CI Build
Status](https://travis-ci.org/bgreenwell/RBitmoji.svg?branch=master)](https://travis-ci.org/bgreenwell/RBitmoji)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/bgreenwell/RBitmoji?branch=master&svg=true)](https://ci.appveyor.com/project/bgreenwell/RBitmoji)

Ya, this is happening…

## Installation

You can (try to) install the development version of `RBitmoji` from
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

## Basic usage

If you are familiar with Bitmoji, then you know that there are hundreds
of comics available for your avatar, each of which is associated with a
comic id and a tag. As of right now, you can only look up and plot
comics by tag, but in the future, we’ll add an id argument as well.
Also, note that many comics are associated with multiple tags and vice
versa, so use `set.seed()` for reproducibility. Below are some simple
examples (the value of `my_id` was found using the `get_id()`
function).

``` r
# Use set.seed() to generate the same comic everytime for a particular tag
set.seed(101)  # for reproducibility
my_id <- "1551b314-5e8a-4477-aca2-088c05963111-v1"
plot_comic(my_id, tag = "fail")
```

<img src="tools/README-examples-1.png" width="70%" style="display: block; margin: auto;" />

``` r

# Another example
plot_comic(my_id, tag = "time magazine")
```

<img src="tools/README-examples-2.png" width="70%" style="display: block; margin: auto;" />

``` r

# Some tags are associated with multiple comics
par(mfrow = c(2, 2))
for (i in 1:4) plot_comic(my_id, tag = "cool")

# Overlay comics on various plots
comic <- get_comic(my_id, tag = "volcano", transparent = TRUE)
library(ggplot2)
```

<img src="tools/README-examples-3.png" width="70%" style="display: block; margin: auto;" />

``` r
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  annotation_raster(comic, xmin = 1, xmax = 3, ymin = 1.5, ymax = 2.5)
```

<img src="tools/README-examples-4.png" width="70%" style="display: block; margin: auto;" />

``` r

# You have two ids, you can also plot comics with friends
set.seed(102)  # for reproducibility
plot_comic(c(my_id, my_id), tag = "vomit")
plot_comic(c(my_id, my_id), tag = "drink")
```

<img src="tools/README-examples-5.png" width="70%" style="display: block; margin: auto;" />

## Inspirations

  - <https://github.com/JoshCheek/bitmoji>

  - <https://github.com/matthewnau/randmoji>

  - <https://github.com/hadley/emo>
