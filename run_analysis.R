# Getting and cleaning data - course project
library(dplyr)

# Load the datasets from the individual files
features <- read.table("./UCI HAR Dataset/features.txt", 
                       stringsAsFactors = FALSE)
list.of.features <- features[,2]

activity.type <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                            stringsAsFactors = FALSE)
list.of.activities <- activity.type[,2]

X.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
#appropriate labels added to vars
colnames(X.train) <- list.of.features

# Filter out the columns with mean and std deviation
meas.names <- colnames(X.train)
req.meas.names <- meas.names[grep("mean\\(\\)|std\\(\\)", meas.names)]

X.train <- X.train[,colnames(X.train) %in% req.meas.names]

y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y.train <- rename(y.train, activity = V1)
y.train$activity <- factor(y.train$activity,
                           levels = c(1,2,3,4,5,6),
                           labels = list.of.activities )

subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject.train <- rename(subject.train, subject = V1)

X.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X.test) <- list.of.features

X.test <- X.test[,colnames(X.test) %in% req.meas.names]

y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y.test <- rename(y.test, activity = V1)
y.test$activity <- factor(y.test$activity,
                           levels = c(1,2,3,4,5,6),
                           labels = list.of.activities )

subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject.test <- rename(subject.test, subject = V1)

# Horizontally combine the variables for matrix X, and columns subject and y
# for training and test sets separately
complete.train <- cbind(subject.train, X.train, y.train)
complete.test <- cbind(subject.test, X.test, y.test)

# Merge the individual datasets into a single dataset
complete.dataset <- rbind(complete.train, complete.test)





