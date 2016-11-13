# CodeBook
This code book describes the variabels used in the code.

## The data sources
- Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables used
- trainData: contains the train data of the X_train file
- trainLabel: contains the train data of the Y_train file
- trainSubject: contains the train data of the subject_train file
- testData: contains test data of the X_test file
- testLabel: contains the test data of the Y_train file
- testSubject: contains the test data of the subject_test file
- joinData: contains the joined trainData and testData
- joinLabel: contains the joined trainLabel and testLabel
- joinSubject: contains the joined trainSubject and testSubject
- features: holds the features data
- meanStdIndices: contains the Mean and Std indices data
- activity: holds the activity labels
- activityLabel: contains the processed activity labels
- cleanedData: contains the cleaned data
- subjectLen: holds the length of the joinSubject table
- activityLen: holds the length of the activity data
- columnLength: the number of columns in cleanedData
- result: a variable used during the cleaning of the data
- bool1: is the subject the current record
- bool2: is the activity the current record
- row: a variable used during the cleaning of the data

