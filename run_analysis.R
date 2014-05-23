library(reshape2)

# merging subject and activity data from training and test sets:

subject <- rbind(read.table("./test/subject_test.txt"),read.table("./train/subject_train.txt"))
activity <- rbind(read.table("./test/y_test.txt"),read.table("./train/y_train.txt"))


# use apply with mean and sd functions to extract only the measurements on the mean and standard deviation for each measurement, while merging training and test sets:

body_acc_x_mean <- apply(rbind(read.table("./test/Inertial Signals/body_acc_x_test.txt"),read.table("./train/Inertial Signals/body_acc_x_train.txt")),1,mean)
body_acc_x_sd <- apply(rbind(read.table("./test/Inertial Signals/body_acc_x_test.txt"),read.table("./train/Inertial Signals/body_acc_x_train.txt")),1,sd)
body_acc_y_mean <- apply(rbind(read.table("./test/Inertial Signals/body_acc_y_test.txt"),read.table("./train/Inertial Signals/body_acc_y_train.txt")),1,mean)
body_acc_y_sd <- apply(rbind(read.table("./test/Inertial Signals/body_acc_y_test.txt"),read.table("./train/Inertial Signals/body_acc_y_train.txt")),1,sd)
body_acc_z_mean <- apply(rbind(read.table("./test/Inertial Signals/body_acc_z_test.txt"),read.table("./train/Inertial Signals/body_acc_z_train.txt")),1,mean)
body_acc_z_sd <- apply(rbind(read.table("./test/Inertial Signals/body_acc_z_test.txt"),read.table("./train/Inertial Signals/body_acc_z_train.txt")),1,sd)

body_gyro_x_mean <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_x_test.txt"),read.table("./train/Inertial Signals/body_gyro_x_train.txt")),1,mean)
body_gyro_x_sd <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_x_test.txt"),read.table("./train/Inertial Signals/body_gyro_x_train.txt")),1,sd)
body_gyro_y_mean <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_y_test.txt"),read.table("./train/Inertial Signals/body_gyro_y_train.txt")),1,mean)
body_gyro_y_sd <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_y_test.txt"),read.table("./train/Inertial Signals/body_gyro_y_train.txt")),1,sd)
body_gyro_z_mean <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_z_test.txt"),read.table("./train/Inertial Signals/body_gyro_z_train.txt")),1,mean)
body_gyro_z_sd <- apply(rbind(read.table("./test/Inertial Signals/body_gyro_z_test.txt"),read.table("./train/Inertial Signals/body_gyro_z_train.txt")),1,sd)

total_acc_x_mean <- apply(rbind(read.table("./test/Inertial Signals/total_acc_x_test.txt"),read.table("./train/Inertial Signals/total_acc_x_train.txt")),1,mean)
total_acc_x_sd <- apply(rbind(read.table("./test/Inertial Signals/total_acc_x_test.txt"),read.table("./train/Inertial Signals/total_acc_x_train.txt")),1,sd)
total_acc_y_mean <- apply(rbind(read.table("./test/Inertial Signals/total_acc_y_test.txt"),read.table("./train/Inertial Signals/total_acc_y_train.txt")),1,mean)
total_acc_y_sd <- apply(rbind(read.table("./test/Inertial Signals/total_acc_y_test.txt"),read.table("./train/Inertial Signals/total_acc_y_train.txt")),1,sd)
total_acc_z_mean <- apply(rbind(read.table("./test/Inertial Signals/total_acc_z_test.txt"),read.table("./train/Inertial Signals/total_acc_z_train.txt")),1,mean)
total_acc_z_sd <- apply(rbind(read.table("./test/Inertial Signals/total_acc_z_test.txt"),read.table("./train/Inertial Signals/total_acc_z_train.txt")),1,sd)


# all values are now merged into one dataset, including: subject, activity, and mean and standard deviation for each measurement

dataset <- cbind(subject,activity,
                 body_acc_x_mean,body_acc_x_sd,body_acc_y_mean,body_acc_y_sd,body_acc_z_mean,body_acc_z_sd,
                 body_gyro_x_mean,body_gyro_x_sd,body_gyro_y_mean,body_gyro_y_sd,body_gyro_z_mean,body_gyro_z_sd,
                 total_acc_x_mean,total_acc_x_sd,total_acc_y_mean,total_acc_y_sd,total_acc_z_mean,total_acc_z_sd
                 )


# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names:

colnames(dataset)[1] <- 'subject'
colnames(dataset)[2] <- 'activity'
dataset[dataset$activity==1,'activity']<-'WALKING'
dataset[dataset$activity==2,'activity']<-'WALKING_UPSTAIRS'
dataset[dataset$activity==3,'activity']<-'WALKING_DOWNSTAIRS'
dataset[dataset$activity==4,'activity']<-'SITTING'
dataset[dataset$activity==5,'activity']<-'STANDING'
dataset[dataset$activity==6,'activity']<-'LAYING'
dataset$activity<-as.factor(dataset$activity)
dataset$subject<-as.factor(dataset$subject)


# Finally, uses melt and dcast to create a second, independent tidy data set showing the average of each variable for each activity and each subject:

melted <- melt(dataset,id.vars=c("subject","activity"))
tidy <- dcast(melted, subject + activity ~ variable, fun.aggregate=mean)

# write tidy data set to csv file
write.csv(tidy, file="tidy.csv")
