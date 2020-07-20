library(dplyr)
# grammar for data manipulation

#defining the file name to be downloaded and the working path
#change accordingly to your settings
filename <- "Coursera_project.zip"
path <- "/Volumes/HP x755w/Coursera/R project/"

#seting the working path
setwd(path)

# Checking if archieve already exists
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Assigning data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# We are required to (1) merge the training and the test sets to create one data set.
xall <- rbind(x_train, x_test)
yall <- rbind(y_train, y_test)
subjectall <- rbind(subject_train, subject_test)
merged_data <- cbind(subjectall, yall, xall)

# (2) Extract only the measurements on the mean and standard deviation for each measurement.
tidyd <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# (3) Uses descriptive activity names to name the activities in the data set.
tidyd$code <- activities[tidyd$code, 2]

# (4) Appropriately labels the data set with descriptive variable names.
names(tidyd)[2] = "activity"
names(tidyd) <- gsub("Acc", "accelerometer", names(tidyd))
names(tidyd) <- gsub("Gyro", "gyroscope", names(tidyd))
names(tidyd) <- gsub("BodyBody", "body", names(tidyd))
names(tidyd) <- gsub("Mag", "magnitude", names(tidyd))
names(tidyd) <- gsub("^t", "time", names(tidyd))
names(tidyd) <- gsub("^f", "frequency", names(tidyd))
names(tidyd) <- gsub("tBody", "timebody", names(tidyd))
names(tidyd) <- gsub("-mean()", "mean", names(tidyd), ignore.case = TRUE)
names(tidyd) <- gsub("-std()", "stdev", names(tidyd), ignore.case = TRUE)
names(tidyd) <- gsub("-freq()", "frequency", names(tidyd), ignore.case = TRUE)
names(tidyd) <- gsub("angle", "angle", names(tidyd))
names(tidyd) <- gsub("gravity", "gravity", names(tidyd))

# (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
sdata <- tidyd %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = mean))
write.table(sdata, "sdata.txt", row.name=FALSE)







