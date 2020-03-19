# load dplyr library for easy cleansing
library(dplyr)

dataFolder <- "UCI HAR Dataset"
activity.labels <- read.table(paste(dataFolder,"/activity_labels.txt",sep=""),header=FALSE)
features <- read.table(paste(dataFolder,"/features.txt",sep=""),header=FALSE)

# read train
dataFolder <- "UCI HAR Dataset/train"
subject.train <- read.table(paste(dataFolder,"/subject_train.txt",sep=""),header=FALSE)
x.train <- read.table(paste(dataFolder,"/X_train.txt",sep=""),header=FALSE)
y.train <- read.table(paste(dataFolder,"/y_train.txt",sep=""),header=FALSE)

# read test
dataFolder <- "UCI HAR Dataset/test"
subject.test <- read.table(paste(dataFolder,"/subject_test.txt",sep=""),header=FALSE)
x.test <- read.table(paste(dataFolder,"/X_test.txt",sep=""),header=FALSE)
y.test <- read.table(paste(dataFolder,"/y_test.txt",sep=""),header=FALSE)

# task #1
# merge data set to form one data set
tidydatax <- rbind(x.train,x.test)
tidydatay <- rbind(y.train,y.test)
tidydataysubject <- rbind(subject.train,subject.test)

# add headers
names(tidydatax) <- features$V2


# task #2
# extract the mean and standard deviation for each measurement.
tidydatax <- tidydatax[, grep("std|mean\\(", names(tidydatax), value=TRUE)] 

# task #3 - Use descriptive activity names to name the activities in the data set
# this is done by binding new columns from the subject dataset using activity_labels e.g. "3" means "WALKING_DOWNSTAIRS"
names(tidydatay)="performedactivityID"
names(activity.labels)=c("performedactivityID","performedactivity")


#loop or usr of factors
tidydatay[,1] <- as.character(factor(tidydatay$performedactivityID, levels = activity.labels[,1], labels = activity.labels[,2]))

#rename the column because it was merged on performedactivityID
names(tidydatay)="performedactivity" 
tidydatax <- cbind(tidydatay,tidydatax) 
#tidyDataX <- cbind(tidyDatay[,2],tidyDataX)

names(tidydataysubject) = "inidividuum"
tidydatax <- cbind(tidydataysubject,tidydatax) 


# task #4 - Appropriately labels the data set with descriptive variable names.

#rename the header to tidy data names
names(tidydatax) <- gsub("[-]std\\(\\)[-]?","std",names(tidydatax));
names(tidydatax) <- gsub("[-]mean\\(\\)[-]?","mean",names(tidydatax));
names(tidydatax) <- tolower(names(tidydatax));


# task #5 - #creating a tidy dataset file
tidydata <- group_by(tidydatax,inidividuum,performedactivity) %>% summarise_each(funs(mean)) # dim(tidyData)   [1] 180  68

#  View(tidyData)
write.table(tidydata, file = "tidydataset.txt", row.names = FALSE,sep="\t")
