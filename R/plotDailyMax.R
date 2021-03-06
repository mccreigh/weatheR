#' Plot Daily Max Temp for Multiple Cities
#'
#'
#' This function requires that the dataframe fed into the funciton have columns named 'TEMP' for temperature,
#' 'city' for the city or identifier, 'YR' for the year, 'M' for month, and 'D' for the day.
#'
#' @param hourlyDF Must be a dataframe with columns for TEMP, city, YR, M, and D
#' @return Plots the daily max temperateu of one or multiple cities
#' @examples
#' \dontrun{
#' data(stations)
#' cities <- c("Nairobi, Kenya", "Tema, Ghana", "Accra, Ghana", "Abidjan, Ivory Coast")
#' hourly.data <- getInterpolatedDataByCity(cities, station.list, 5, 2010, 2013, 100, 3, .05)
#' plotDailyMax(hourly.data)
#' }
#' @export

plotDailyMax <- function(hourlyDF)
{
  d.max <- aggregate(TEMP ~ city + YR + M + D, hourlyDF, max)
  d.max <- d.max[with(d.max, order(city, YR, M, D)),]
  d.max$day <- as.POSIXct(paste(d.max$YR, d.max$M, d.max$D,sep="-"),format="%Y-%m-%d")
  p1 <- ggplot(d.max, aes(x=day, y=TEMP)) + geom_point() + facet_grid(city ~.)
  plot(p1)
}

