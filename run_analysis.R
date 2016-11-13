# Getting and Cleaning data Peer Assignment

# Preperation for the assignment
# These steps aren't part of the assignment
# so they are marked as comment
# Working on a Windows machine

# Download the working data
#if (!file.exists("data")) {
#    dir.create("data")
#}
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl,destfile="./data/dataset.zip")
#dateDownloaded <- date()

# Unzip the data into the /data directory
#unzip(zipfile="./data/dataset.zip",exdir="./data")

# Set the path to the working files
#setwd("C:/Users/erik.altink/Documents/data")

# From here are the answers to the questions

##
#1. Merges the training and the test sets to create one data set.
##

# Read the data into variables
# Read the training data
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
# Read the label data
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
# Read the subject data
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read the test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
# Read the test label data
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
# Read the test subject data
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Join the training and test data
joinData <- rbind(trainData, testData)
# Join the training and test labels
joinLabel <- rbind(trainLabel, testLabel)
# Join the training and test subjects
joinSubject <- rbind(trainSubject, testSubject)

##
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 

# Read the features file
features <- read.table("./UCI HAR Dataset/features.txt")
# Grep the mean and std data into an array
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# Join the data
joinData <- joinData[, meanStdIndices]

# Improve the labels of the data
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove the "()" data
names(joinData) <- tolower(names(joinData)) # make names lowercase (from lesson 1)
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

##
#3. Uses descriptive activity names to name the activities in the data set
##

# Read data from the labels file
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Retrieve activities and use as descriptive activity names
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

##
#4. Appropriately labels the data set with descriptive activity names. 
##

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)

# write out the Merged dataset
write.table(cleanedData, "./UCI HAR Dataset/mergedData.txt") 

##
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##

# Get dimension data
subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
# Make a new matrix from the data
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
# Store as data frame
result <- as.data.frame(result)
# Set the column names
colnames(result) <- colnames(cleanedData)
# Fill the data
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == cleanedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}

# save tidy dataset file.
write.table(result, "./UCI HAR Dataset/tidyDataWithMeans.txt", row.name=FALSE) 
