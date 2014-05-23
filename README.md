HARproject
==========

* run_analysis.R on this repo performs the steps described below; the R script itself also includes comments describing each stage of the analysis.

* First, the rbind function merges the subject and activity data from training and test sets.
* Second, the apply function applies mean and sd functions to extract only the mean and standard deviation for each measurement of Inertial Signals, while merging the training and test sets.
* The cbind function creates a single dataset including subject and activity columns and the mean and standard deviations for measurements of Inertial Signals.
* The activity column is modified to a factor which appropriately labels the dataset with descriptive activity names.
* Finally, melt and dcast are used to create a second, independent tidy data set showing the average of each variable for each activity and each subject.
