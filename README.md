# Predicting Race statistics for a runner in the _USA Track and Field All-time Master Runners_ list

The summarized data of the _USA Track and Field All-time Master Runners_ is tabulated in the __usa track and field all-time data.csv__ file.  The statistics were obtained from the USA Track and Field site at http://www.usatf.org/statistics/All-Time-Lists/Masters-Age-Graded-Road-Running.aspx. 

The __usa track and field.R__ file contains the scrips to create the following R files that are used by the ShinyApp.
* __agelist.Rda__ - contains the age of competitors
* __dat.Rda__ - contains an R data frame with the cleansed __usa track and field all-time data.csv__ data.
* __cubist_mod.Rda__ - is the saved Cubist model developed in __usa track and field.R__ and loaded by __server.R__ for predicting the race pace of the competitors.  A cubist model is a _tree_ model with _linear regressions_ models at the terminal leaves (http://cran.r-project.org/web/packages/Cubist/vignettes/cubist.pdf).

The __server.R__ and __ui.R__ files read the data and use the cubist model, saved to __cubist_mod.Rda__, to predict the race time for a given _Gender_, _Age_, and _Race Distance_ for an average master runner in the list _USATF All-time_ data.
