# CodeBook

##Variables

testData - table contents of test/X_test.txt
trainData - table contents of train/X_train.txt
X - Measurement data. Combined data set of the two above variables
testSub - table contents of test/subject_test.txt
trainSub - table contents of test/subject_train.txt
S - Subjects. Combined data set of the two above variables
testLabel - table contents of test/y_test.txt
trainLabel - table contents of train/y_train.txt
Y - Data Labels. Combined data set of the two above variables.
featuresList - table contents of features.txt
features - Names of for data columns derived from featuresList
keepColumns - logical vector of which features to use in tidy data set
activities - table contents of activity_labels.txt. Human readable
tidyData - subsetted, human-readable data ready for output according to project description.
uS - unique subjects from S
nS - number of unique subjects
nA - number of activities
nC - number of columns in tidyData
td - second tiny data set with average of each variable for each activity and subject

##Output
tidy_data_set.txt

tidy_data_set.txt is a 180x68 data frame.

The first column contains subject IDs.
The second column contains activity names.
The averages for each of the 66 attributes are in columns 3-68.
