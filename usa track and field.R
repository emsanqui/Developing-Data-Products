library(caret)
library(Cubist)

# U.S. All-time List - Masters Age Graded Road Running (by distance)
# As of 3/2/2012
# http://www.usatf.org/statistics/All-Time-Lists/Masters-Age-Graded-Road-Running.aspx

dat <- read.csv("usa track and field all-time data.csv")

summary(dat)


# CLEAN DATA ####
dat$Seconds <- as.numeric(dat$Seconds)
dat$Gender <- as.factor(dat$Gender)
dat$Male[dat$Gender=="F"] <- 0
dat$Male[dat$Gender=="M"] <- 1
save(dat,file="dat.Rda")


 
# PARTITION DATA ####
set.seed(777)
train <- createDataPartition(dat$Seconds,list=F,p=.8)
training <- dat[train,]
testing <- dat[-train,]




# SAVE DATA FILES TO BE LOADED BY SHINY APP ####
age.list <- unique(testing[order(testing$Age),"Age"])
save(age.list,file="agelist.Rda")
save(dat,file="dat.Rda")




# PLOT FUNCTION ####
par(mfrow=c(1,2))

# plot function
plot.model <- function(model, x.data, y.data, main.label){
    predicted <- predict(model,x.data)
    r.sqr <- cor(predicted , y.data , method="pearson")^2
    rmse <- sqrt(mean((predicted - y.data)^2))
    plot(x=predicted , y=y.data, 
         ylab="Predicted" , xlab="Actual" , 
         main=paste(model$method,main.label,
                    "RMSE:",round(rmse),
                    "\nRsqr:",round(r.sqr,3))
    )
    abline(0,1,col="red") 
}




# cubist model ####
fitControl <- trainControl(
    ## 10-fold CV
    method = "repeatedcv",
    number = 10,
    ## repeated ten times
    repeats = 10,
    p=.7)

tuneGrid <-  expand.grid(committees=c(1:42)
                         , neighbors=c(0:9)
)

set.seed(77777)
cubist.mod <- train(x=training[,c("Male","Meters","Age")]
                    , y=training$Seconds
                    , method="cubist"
                    #, trControl=fitControl
                    , tuneGrid=tuneGrid
                    )
# save(cubist.mod,file="./cubist_mod.Rda")
summary(cubist.mod)
cubist.mod$bestTune

plot.model(cubist.mod , training , training$Seconds , "Training Data...")
plot.model(cubist.mod , testing , testing$Seconds , "Testing Data...")



male.pred <- data.frame(Age=NA,Seconds=NA,Gender=NA,Meters=NA)
for(age in c(40:100)){
    male.pred <- rbind(male.pred ,
                  data.frame(Age=age ,
                             Seconds=predict(cubist.mod, data.frame(Male=1, Meters=5000 , Age=age) ) ,
                             Gender="M" ,
                             Meters=5000
                             )
                  )
}




# ggplot of predicted pace from Gender, Distance, and Age
qplot(x=Age , y=(Seconds/60)/(Meters/1609.34) , data = dat 
           , colour=Gender 
           , geom = c("point", "smooth") 
           , span = 1) + ylab("Minutes / Mile") +
    geom_vline(xintercept = 90 , colour="green") +
    geom_hline(yintercept = (predict(cubist.mod,
                                    data.frame(Male=0 ,
                                               Meters=5000 ,
                                               Age=70)
                                    )/60) / (5000/1609.34)
                            
               , colour="green")




predict(cubist.mod, data.frame(Male=0 ,  Meters=5000 , Age=40))
