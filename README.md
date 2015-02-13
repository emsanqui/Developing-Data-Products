# Developing-Data-Products

The summarized data the USA Track and Field All-time Master Runners is tabulated in the "usa track and field all-time data.csv" file. The "usa track and field.R" file contains the scrips to create the "agelist.Rda", "cubist_mod.Rda", and "dat.Rda" R data files that are used by the ShinyApp.
The "server.R" and "ui.R" files read the data and uses a cubist model to predict the race time for a given Gender, Age, and Race Distance for an average master runner in the list.
