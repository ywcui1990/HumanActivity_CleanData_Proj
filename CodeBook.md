Code Book for the HumanActivity_tidy_data
=========================================

Source
-------

The original dataset can be downloaded from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The orignal data contains a 561-feature vector with time and frequency domain variables. 

Data Process
-------
We applied the following transformations to create the tidy dataset:

- Combine training and test dataset into a a single data frame (rbind)
- Merge subject id, activity label, and feature data matrix into a single data frame
- Appropriately labels the data set with descriptive variable names.
- Replace activity id codes with descriptive activity names using the mapping from activity_labels.txt
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Creates the tidy data set with the average of each variable for each activity and each subject. 


Data Description
-------
The cleaned-up data contains 180 rows and 479 columns. The first two columns contains activity label and subject id. The rest of the columns (column 3 to column 479) contains the average of each feature for each activity and each subject. The features are labeled with descriptive names, which are the same as in the [original data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The feature selection scheme are also described in the original dataset. 
