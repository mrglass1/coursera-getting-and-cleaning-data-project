#This R script will generate a tidy data file
#This is a course project for the Coursera Getting and Cleaning Data

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
