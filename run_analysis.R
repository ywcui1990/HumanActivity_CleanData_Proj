setwd('/Users/ywcui/Study/R/projects/HumanActivity_CleanData_Proj')
require(reshape)

download.file(url="http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="HumanActivityData.zip")
# unzip data to folder ./UCI HAR Dataset
unzip("HumanActivityData.zip")

# load feature name
featureName <- read.table('./UCI HAR Dataset/features.txt')
names(featureName) <- c("feature_id","feature_name")

# load activity labels
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
names(activity_labels) <- c("activity_id","activity_name")

# Merges the training and the test sets to create one data set.

# subject id
subject <-rbind(read.table('./UCI HAR Dataset/train/subject_train.txt'),
                read.table('./UCI HAR Dataset/test/subject_test.txt')) 
names(subject) <- "subject"

# data label
label <-rbind(read.table('./UCI HAR Dataset/train/y_train.txt'), 
              read.table('./UCI HAR Dataset/test/y_test.txt')) 
names(label) <- "label"

# feature data
feature <- rbind(read.table('./UCI HAR Dataset/train/X_train.txt'),
                      read.table('./UCI HAR Dataset/test/X_test.txt')) 

# Appropriately labels the data set with descriptive variable names.
names(feature) <- featureName$feature_name

data <- cbind(subject, label, feature)

# Extracts only the measurements on the mean and standard deviation for each measurement.

meanMeasurement <- grep("mean", featureName$feature_name, ignore.case=TRUE)
stdMeasurement <- grep("std", featureName$feature_name, ignore.case=TRUE)
useCol <- c(c(1,2), meanMeasurement+2, stdMeasurement+2)
useCol <- sort(unique(useCol))
data <- data[,useCol]

# Use descriptive activity names to name the activities in the data set

data$label <- factor(data$label, levels=activity_labels$activity_id,
                        labels=activity_labels$activity_name)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
data$subject <- factor(data$subject, levels=c(1:30))

# aggregate data based on subject and activity type (label) using the melt and cast function
tidydata <- melt.data.frame(data) 
tidydata <- cast(tidy, formula = label + subject ~ ..., fun.aggregate=mean)

# save tidy data
write.table(tidydata, "HumanActivity_tidy_data.txt")