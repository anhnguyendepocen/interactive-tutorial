library(animint)
data(WorldBank, package="animint")
WorldBank1975 <- subset(WorldBank, year==1975)

## Ch2 Exercise 1: try changing the aes mapping of the ggplot, and
## then making a new animint. Quantitative variables like population
## are best shown using the x/y axes or point size. Qualitative
## variables like lending are best shown using point color or fill.
viz.1975 <- list(
  scatter=ggplot()+
  geom_point(
    mapping=aes(
      x=life.expectancy,
      y=fertility.rate,
      color=region),
    data=WorldBank1975))
structure(viz.1975, class="animint")

## Ch2 Exercise 2: use animint to create a data viz with three plots,
## by creating a list with three ggplots.
WorldBankBefore1975 <- subset(WorldBank, 1970 <= year & year <= 1975)
viz.several.plots <- list(
  scatter=ggplot()+
    geom_point(
      mapping=aes(
        x=life.expectancy,
        y=fertility.rate,
        color=region),
      data=WorldBank1975)+
    geom_path(
      aes(
        x=life.expectancy,
        y=fertility.rate,
        color=region,
        group=country),
      data=WorldBankBefore1975),
  tsFert=ggplot()+
    geom_line(aes(x=year, y=fertility.rate, color=region, group=country),
              data=WorldBank))
structure(viz.several.plots, class="animint")

## Ch3 Exercise 1: add another geom or plot with
## aes(showSelected=year) to the following data viz.
viz.scatter <- list(
  scatter=ggplot()+
    geom_point(aes(x=life.expectancy, y=fertility.rate, color=region,
                   showSelected=year),
               data=WorldBank))
structure(viz.scatter, class="animint")

## Ch3 Exercise 2: make an animated data viz that does NOT use smooth
## transitions.

## Ch4 Exercise 1: how to get the geom_text to disappear along with
## the point when the region legend is clicked? Hint: add one aes to
## the geom_text.
viz.text <- list(
  scatter=ggplot()+
    geom_point(aes(x=life.expectancy, y=fertility.rate, color=region,
                   key=country,
                   showSelected=year,
                   clickSelects=country),
               data=WorldBank)+
    geom_text(aes(x=life.expectancy, y=fertility.rate, label=country,
                  key=country,
                  showSelected=year,
                  showSelected2=country),
              data=WorldBank),
  duration=list(year=2000))
structure(viz.text, class="animint")

## Ch4 Exercise 2: how to get the geom_text to disappear when you
## click it?  Hint: add one aes to the geom_text.
viz.multiple <- list(
  scatter=ggplot()+
    geom_point(aes(x=life.expectancy, y=fertility.rate, color=region,
                   key=country,
                   showSelected=year,
                   clickSelects=country),
               data=WorldBank)+
    geom_text(aes(x=life.expectancy, y=fertility.rate, label=country,
                  key=country,
                  showSelected=year,
                  showSelected2=country,
                  showSelected3=region), 
              data=WorldBank),
  first=list(
    year=1970,
    country="United States",
    region=c("North America", "South Asia")),
  selector.types=list(country="multiple"),
  duration=list(year=2000))
structure(viz.multiple, class="animint")

## Ch4 Exercise 3: add layers to the scatterplot in the following data
## viz, and animate it!
viz.timeSeries <- viz.multiple
years <- data.frame(year=unique(WorldBank$year))
viz.timeSeries$timeSeries <- ggplot()+
  geom_tallrect(aes(xmin=year-0.5, xmax=year+0.5,
                    clickSelects=year),
                alpha=0.5,
                data=years)+
  geom_line(aes(x=year, y=fertility.rate, group=country, color=region,
                clickSelects=country),
            size=3,
            alpha=0.6,
            data=WorldBank)
structure(viz.timeSeries, class="animint")
