# Code Book

   The script is called "run_analysis.R" it performs the required tasks and includes a section with the downloading of the data, its extraction and preparation stages prior to the actual requirements.

#### 0 - Required packages
   We will be using the *"dplyr"* package.
   
#### 1 - Data Download
   The first step is the actual data download and extraction into a folder (UCI HAR Dataset)
   
#### 2 - Each one of the datasets is assigned to variables in R for further manipulation
- features.txt goes to *features* (list of all features)
- activity_labes.txt goes to *activity_labels* (links the class labels with their activity name. The activities were WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- subject_test.txt goes to *subject_test* (the test data of the volunteer subjects being measured - 30 volunteers-)
- x_test.txt goes to *x_test* (test set)
- y_test.txt goes to *y_test* (test labels)
- subject_train.txt goes to *subject_train* (train data of subjects)
- X_train.txt goes to *x_train* (train set)
- y_train.txt goes to *y_train* (train labels)

#### 3- Merging of the training and testing sets into a single one
   Using rbind() function we merged x_train and x_test into *xall*
   Using rbind() function we also merged y_train and y_test into *yall*
   Using rbind() function we also merged subject_train and subject_test into *subject_all*
   Finally, using cbind() function, we merged the subject, yall, and xall into *merged_data*


#### 4- Extraction of only the measurements on the mean and standard deviation for each measurement
   We created  *tidyd* by subsetting the merged_data, selecting the subject, code and measurements on the mean and standard deviation.

#### 5 - Naming correction on the Activities in the data set, 
   Code column in *tidyd* was replaced to activities (we use no capital letter in the naming).
   We replaced "Acc" by "accelerometer"
               "Gyro" by "gyroscope"
               "BodyBody" by "body"
               "Mag" by "magnitude",
               using regular expressions, if the comun name started with an "t" it was replaced by "time", and the same was done with the starting "f" that was replaced by "frequency"
               also correctd mean, stdev, frequency, angle and gravity.

#### 6 - Creation of a Second, independent tidy data set with the average of each variable for each activity and each sbject
   We created *sdata* by summarizing *tidyd* with the mean of each variable for each activity and subject (using summarise_all() and group_by()).
   The sdata was exported into sdata.txt
   
-----------

