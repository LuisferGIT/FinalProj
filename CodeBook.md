
The run_analysis.R script downloads data and then executes the steps outlined in the course project definition.
Download the dataset
The dataset is downloaded and extracted in the folder named UCI HAR Dataset
 Assign each data to a variable
features <- features.txt : 561 rows, 2 columns
activity_labels <- activity_labels.txt : 6 rows, 2 columns
subject_test <- test/subject_test.txt : 2947 rows, 1 column
y_test <- test/y_test.txt : 2947 rows, 1 columns
y_train <- test/y_train.txt : 7352 rows, 1 columns
subject_train <- test/subject_train.txt : 7352 rows, 1 column
x_train <- test/X_train.txt : 7352 rows, 561 columns
x_test <- test/X_test.txt : 2947 rows, 561 columns

## Step 1:  Merges the training and the test sets to create one data set
data_X is created by merging x_train and x_test using rbind() function: 10299 rows, 561 columns
data_Y is created by merging y_train and y_test using rbind() function: 10299 rows, 1 column
Subject is created by merging subject_train and subject_test using rbind() function: 10299 rows, 1 column
Data_union is created by merging Subject, Y and X using cbind() function: 10299 rows, 563 column

## Step 2: Extracts just the measurements on the mean and standard deviation for each variable
TidyData is created by subsetting Data_union, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement: 10299 rows, 88 columns

## Step 3: Uses descriptive activity names to name the activities in the data set
The TidyData code column is replaced with the corresponding activity taken from the second column of the activity_labels

## Step 4:  Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into subject_activity
All Acc in column’s name replaced by Accelerometro
All Gyro in column’s name replaced by Giroscopio
All Body in column’s name replaced by Cuerpo
All BodyBody in column’s name replaced by Cuerpo
All Mag in column’s name replaced by Magnitud
All start with character t in column’s name replaced by Tiempo
All start with character f in column’s name replaced by Frecuencia
All Mean in column’s name replaced by Media
All std in column’s name replaced by DevS
All jerk in column’s name replaced by Sacudida
All angle in column’s name replaced by Angulo
All Gravity in column’s name replaced by Gravedad

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData is created by summarizing TidyData taking the grouped means of each variable for Subject_activity and Subject, finally FinalData is written in the FinalData.txt file.
