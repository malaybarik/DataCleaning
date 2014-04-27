##Reading Activity List and Feature List
activityL <- read.table("UCI HAR Dataset//activity_labels.txt",  col.names=c("a_ID",  "a_Name"))
feature <- read.table("UCI HAR Dataset//features.txt", col.names=c("f_ID", "f_name"))

##Creating a Feature Vector
fea_vect <-""
for (i in 1:length(feature$f_name)){
  fea_vect[i] <- as.character(feature$f_name[i] )
}

## Reading Subject Data
sub_train <- read.table("UCI HAR Dataset//train/subject_train.txt")
sub_test <- read.table("UCI HAR Dataset//test/subject_test.txt")
sub_ttrain <- rbind(sub_train, sub_test)

##Getting subject list in a vector
sub_vect  <- "Subject"
for (i in 1:length(sub_ttrain[,1])){      
  sub_vect[i+1] <- sub_ttrain[i,]
}

## Reading feature Data
feature_train <- read.table("UCI HAR Dataset//train/y_train.txt")
feature_test <- read.table("UCI HAR Dataset//test//y_test.txt")
fea_ttrain <- rbind(feature_train, feature_test)

##Getting activity names in a vector
act <- as.character(activityL$a_Name)
act_vect  <- "Activity"
for (i in 1:length(fea_ttrain[,1])){      
  act_vect[i+1] <- act[fea_ttrain[i,]]
}

##Creating a list of row names combining subject and activity
sub_act <- "Sub+Activity"
for (i in 1:length(fea_ttrain[,1])){
  sub_act[i+1] <- paste(sub_vect[i], act_vect[i], sep="_")
  }

##Reading test result data 
x_train <- read.table("UCI HAR Dataset//train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
ttrain <- rbind(x_test, x_train)

##Adding fea_vect as first row of the dataframe
wHead <- rbind(fea_vect, ttrain)

##Adding sub_act as Row names
#combined <- cbind(sub_act,wHead)

## read reduced variables (mean and std only)
fea_reduc <- read.table("UCI HAR Dataset/features-reduced.txt")
reduced <- act_vect
for (i in fea_reduc$V1){
  reduced <- cbind(reduced, wHead[,i])
}

##Adding Subject to reduced dataset
data_s <- data.frame(reduced)

xt <- xtabs(Subject~Activity, data=data_s)

