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

## Read the data frames and store in each variable:
## features store the names of the measurements
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
## subject_test store Id numbers of the subjects
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
##y_train and y_test variables are data frame objects with one column holding the index number of the activities
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
## subject_test store Id numbers of the subjects
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
## x_train and x_test are data frame objects with columns holding the measurments data.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)


## Step 1: Merges the training and the test sets to create one data set.
data_X <- rbind(x_train, x_test)
data_Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Data_union <- cbind(Subject, data_Y, data_X)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <- Data_union %>% select(subject, code, contains("mean"), contains("std"))

## Step 3: Uses descriptive activity names to name the activities in the data set.
TidyData$code <- activity_labels[TidyData$code, 2]

## Step 4: Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "Subject_activity"
names(TidyData)<-gsub("Acc", "Acelerometro", names(TidyData))
names(TidyData)<-gsub("Gyro", "Giroscopio", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Cuerpo", names(TidyData))
names(TidyData)<-gsub("Body", "Cuerpo", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitud", names(TidyData))
names(TidyData)<-gsub("^t", "Tiempo", names(TidyData))
names(TidyData)<-gsub("^f", "Frequencia", names(TidyData))
names(TidyData)<-gsub(".mean", ".Media", names(TidyData))
names(TidyData)<-gsub("-mean()", "Media", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("mean", "Media", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub(".std()", ".DevS", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "DevS", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frec", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("Freq", "Frec", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("Jerk", "Sacudida", names(TidyData))
names(TidyData)<-gsub("angle", "Angulo", names(TidyData))
names(TidyData)<-gsub("Gravity", "Gravedad", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("Frecuency", "Frecuencia", names(TidyData), ignore.case = TRUE)

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
    group_by(subject, Subject_activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
