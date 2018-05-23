# Load required packages
library(ggimage)
library(ggplot2)
library(grid)
library(png)

# Load vip image
img <- rasterGrob(readPNG("tools/drop-mic.png"),
                  interpolate = TRUE, width = 0.75)

# Hexagon data
hex <- data.frame(x = 1.35 * 1 * c(-sqrt(3) / 2, 0, rep(sqrt(3) / 2, 2), 0,
                                   rep(-sqrt(3) / 2, 2)),
                  y = 1.35 * 1 * c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5))

greys <- RColorBrewer::brewer.pal(9, "Greys")

# Hexagon logo
g <- ggplot() +
  geom_polygon(data = hex, aes(x, y), color = greys[7L],
               fill = "white", size = 3) +
  annotation_custom(img, xmin = -Inf, xmax = Inf, ymin = -0.15, ymax = 1) +
  annotate(geom = "text", x = 0, y = 0.65, color = greys[7L], size = 8,
           label = "RBitmoji", family = "Open Sans Light") +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y)) +
  scale_x_continuous(expand = c(0.04, 0)) +
  scale_y_reverse(expand = c(0.04, 0)) +
  theme_void() +
  theme_transparent() +
  theme(axis.ticks.length = unit(0, "mm"))
print(g)

png("tools/RBitmoji-logo.png", width = 181, height = 209,
    bg = "transparent", type = "cairo-png")
print(g)
dev.off()

svg("tools/RBitmoji-logo.svg", width = 181 / 72, height = 209 / 72,
    bg = "transparent")
print(g)
dev.off()
