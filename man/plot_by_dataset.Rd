% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_by_dataset.R
\name{plot_by_dataset}
\alias{plot_by_dataset}
\title{Plot synchronies by beat structures across datasets}
\usage{
plot_by_dataset(
  df = NULL,
  asynchronies = NULL,
  data = NULL,
  pcols = 1,
  box = FALSE,
  colour = "lightblue"
)
}
\arguments{
\item{df}{data frame to be processed}

\item{asynchronies}{Variable name where the asynchronies are}

\item{data}{Variable name where the beats are}

\item{pcols}{Number of columns for multiple plots (default 1)}

\item{box}{Do the graphics by boxplot}

\item{colour}{colour for the boxplot}
}
\value{
Graphic output
}
\description{
This function plots the calculated asynchronies of instruments and labels these by instruments.
}
\seealso{
\code{\link{plot_by_variable}}, \code{\link{plot_by_pair}}, \code{\link{plot_by_beat}}
}
