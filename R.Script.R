

# # load packages ---------------------------------------------------------

library(tidyverse)    # load the tidyverse package

library(psych)

library(scatterplot3d)




# # read data -------------------------------------------------------------

iris
iris <- as_tibble(iris)
iris

#  Q-1 --------------------------------------------------------------------

rename(
  iris,
  sepal_length = Sepal.Length,
  sepal_width = Sepal.Width,
  petal_lenght = Petal.Length,
  petal_width = Petal.Width
)


# Q-2 ---------------------------------------------------------------------

mutate_each(iris, funs(. * 10), -Species)

# Q-3 ---------------------------------------------------------------------

mutate(iris,
       Sepal.Area = Sepal.Width * Sepal.Length,
       Petal.Area = Petal.Width * Petal.Length)



# Q-4 ---------------------------------------------------------------------

summarise(
  iris,
  sample_size = n(),
  mean = (Sepal.Width),
  max = (Sepal.Width),
  median = (Sepal.Width),
  sem = mean + sqrt(sample_size)
)

scores <- c(2, 4.4, 3, 7, 4.4)
sort(scores)
min(scores)
max(scores)
median(scores)
range(scores)
quantile(scores, .25)


# Q-5 ---------------------------------------------------------------------
  iris_grouped <- group_by(iris, Species)
iris_grouped

iris_summarized <-
  summarise(
  iris_grouped,
  sample_size = n(),
  mean = mean(Petal.Width),
  sd = sd(Petal.Width),
  var = var(Petal.Width),
  stderr = sd / sqrt(sample_size),
  ci_upper = mean + 2 * stderr,
  ci_lower = mean - 2 * stderr
)
iris_summarized




# Q-6 ---------------------------------------------------------------------

ggplot(data = iris) + geom_jitter(
  aes(y = Petal.Width, x = Species, color = Species),
  width = 0.05,
  height = 0.2,
  alpha = 0.5
)

# Q-7 ---------------------------------------------------------------------
ggplot(data = iris) + geom_jitter(
  aes(y = Petal.Width, x = Species, color = Species),
  width = 0.05,
  alpha = 0.5
) +
  geom_crossbar(
    data = iris_summarized,
    mapping = aes(
      x = Species,
      y = mean,
      ymax = ci_upper,
      ymin = ci_lower,
      color = Species
    )
  )


# Q-8 ---------------------------------------------------------------------
ggplot(data = iris) + geom_jitter(
  aes(y = Petal.Width, x = Petal.Length, color = Species),
  width = 0.9,
  height = 0.5,
  alpha = 0.5
)



# As a scatterplot3D --------------------------------------------------------

attach(iris)
scatterplot3d(
  Petal.Length,
  Petal.Width,
  Species,
  pch = 16,
  type = "h",
  angle = 65, box = FALSE, grid = TRUE, col.grid = "red", col.axis = "orange",
  col.lab = "navyblue",
  xlab = "Petal length",
  ylab = "Petal width",
  zlab = "Species",
  color = c("black", "purple", "blue")[as.integer(Species)]
)



