Getting-and-Cleaning-Data-Project
=================================

Getting and cleaning data project

Instructions for how script runs

1) Download file

2) Reads all files into R's environment, and stores them with some appropriate titles

3) Uses the information in the features.txt file in the zip folder as column names for the test and training set in order to properly label each measurement of every column

4) We then eliminate all columns not related to the mean or standard deviation using partial matching

5) We then use the files subject_*.txt, Testlabel.txt, Trainlabel.txt to append to our data sets so we have identifiers on all columns. We also rename those columns to be subject as in subject number and activity, as in the activities measured in experiment

6) Using the activity_label.txt file, we then substitute all the numbers in the activity column (which was added in step 5) with the appropriate activity. eg 1 becomes Walking, 2 becomes Walking upstairs

7) We now merge the Training and Test set of data using the rbind command. The Training set and Test set, at this point in time, should have 2947 observations of 81 variables, and the Training set should have 7352 observations of 81 variables

8) Now, using the aggregate command, we obtain the means and standard deviationsby Subject number and the type of activity their doing for each measurement

9) Finally, we write the data to a file "Cleansmartphonedata.txt"
