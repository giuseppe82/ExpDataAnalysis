library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

library(datasets)
data(airquality)

library(ggplot2)
qplot(Wind, Ozone, data = airquality, geom = "smooth")
qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

qplot(Wind, Ozone, data = airquality)

library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)

qplot(votes, rating, data = movies)
qplot(votes, rating, data = movies) + stats_smooth("loess")

library(ggplot2)
g <- ggplot(movies, aes(x="votes", y="rating"))
print(g)
