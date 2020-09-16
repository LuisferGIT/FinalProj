##Set work directory
setwd("D:/Coursera/Especializacion en Data Science/Curso 3 Getting and Cleaning Data/Semana 4 Subsetting and sorting/FinalProj")

##load package dplyr
library(dplyr)

## the data downloaded from the web will be saved as Data_UCI_Smartphones.zip
filename <- "Data_UCI_Smartphones.zip"

# Verify if file exists in directory and download data from URL
if (!file.exists(filename))
{
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

# Unzip file creates directory UCI HAR Dataset, this verify if directory exists
if (!file.exists("UCI HAR Dataset")) 
{ 
    unzip(filename) 
}

## Read the data frames and store in variables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

