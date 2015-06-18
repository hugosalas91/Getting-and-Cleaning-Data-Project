if(!file.exists("data"))
    dir.create("data")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data/data.zip", method = "curl")
unzip("data/data.zip", exdir = "data")
path_files <- list.files("data/UCI HAR Dataset", recursive=TRUE)
data_features_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
data_subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
data_activity_train <- read.table("data/UCI HAR Dataset/train/Y_train.txt", header = FALSE)
data_features_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
data_subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
data_activity_test <- read.table("data/UCI HAR Dataset/test/Y_test.txt", header = FALSE)

##################################################################
## 1.Merges the training and the test sets to create one data set.
##################################################################

data_features <- rbind(data_features_train, data_features_test)
data_subject <- rbind(data_subject_train, data_subject_test)
data_activity <- rbind(data_activity_train, data_activity_test)
data_features_names <- read.table("data/UCI HAR Dataset/features.txt", head=FALSE)
names(data_features)<- data_features_names$V2
names(data_subject)<-c("subject")
names(data_activity)<- c("activity")
data_subject_activity <- cbind(data_subject, data_activity)
data_all <- cbind(data_features, data_subject_activity)

##################################################################
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
##################################################################

data_mean_and_sd <- data_features_names$V2[grep("mean\\(\\)|std\\(\\)", data_features_names$V2)]
names_mean_and_sd <- c(as.character(data_mean_and_sd), "subject", "activity")
data_all <- subset(data_all, select = names_mean_and_sd)

##################################################################
## 3.Uses descriptive activity names to name the activities in the data set.
##################################################################

activities <- read.table("data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
data_all$activity <- factor(data_all$activity, levels = activities$V1, labels = activities$V2)

##################################################################
## 4.Appropriately labels the data set with descriptive variable names.
##################################################################

names(data_all)<-gsub("^t", "time", names(data_all))
names(data_all)<-gsub("^f", "frequency", names(data_all))
names(data_all)<-gsub("Acc", "Accelerometer", names(data_all))
names(data_all)<-gsub("Gyro", "Gyroscope", names(data_all))
names(data_all)<-gsub("Mag", "Magnitude", names(data_all))
names(data_all)<-gsub("BodyBody", "Body", names(data_all))

##################################################################
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##################################################################

data_all_2 <- aggregate(. ~ subject + activity, data_all, mean)
data_all_2 <- data_all_2[order(data_all_2$subject, data_all_2$activity),]
write.table(data_all_2, file = "tidy_data_set.txt", row.name = FALSE)
