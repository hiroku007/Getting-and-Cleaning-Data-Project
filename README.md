Getting-and-Cleaning-Data-Project
=================================

Getting and cleaning data project

Instructions for how script runs

1) Download file if the .zip file found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip does not exist in working directory

2) Reads all files into R's environment, and stores them with some appropriate titles. There should now be 8 data tables in R's global environment. They are as follows:
  
  a) feature - this is a 1 column data table of all the different types of measurements being taken
  
  b) activity_label - this is a 2 column data table with 6 observations. It relates a number, 1-6 to an activity
  
  c) SubjectTest - This is a 1 column data table with numbers 1-30. It identifies which test subject each row is for in the Testset (see e)
  
  d) Testlabel - This is a 1 column data table with numbers 1-6 that identifies which activity is being done, using the activity_label data frame in b. This also identifies which activity was done in each row of e
  
  e) Testset - this includes measurements of the features indicated in the table feature. d and c identify the activity and subject involved
  
  Similarly, the remaining three tables, SubjectTrain, Trainlabel, and Trainset operate in the same way as c, d, and e.
  
  Each of these tables are read from the zip folder and their file paths can be found in the R script

3) Uses the information in the features.txt file in the zip folder as column names for the test and training set in order to properly label each measurement of every column

4) We then eliminate all columns not related to the mean or standard deviation using partial matching. Trainset should now by 7352 observations of 79 variables and Testset should be 2947 observations of 79 variables

5) We then use the tables, SubjectTest, SubjectTrain, TestLabel, and Trainlabel to identify which subject and which activity each measurement is being taken on. This is done by appending the appropriate tables (SubjectTest and Testlabel to Testset, and SubjectTrain and Trainlabel to Trainset) using cbind.

6) Using the activity_label.txt file, we then substitute all the numbers in the activity column (which was added in step 5) with the appropriate activity. eg 1 becomes Walking, 2 becomes Walking upstairs

7) We now merge the Training and Test set of data using the rbind command. The Training set and Test set, at this point in time, should have 2947 observations of 81 variables, and the Training set should have 7352 observations of 81 variables

8) Now, using the aggregate command, we obtain the means and standard deviationsby Subject number and the type of activity their doing for each measurement. We then bind these tables together, and should obtain a data set called FinalData of 180 observations of 161 variables.

9) Finally, we write the data to a file "Cleansmartphonedata.txt"
