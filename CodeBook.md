---
title: "CodeBook for run_analysis.r"
author: "SteveCutting"
date: "November 22, 2014"
output: html_document
---
***The following describes the step logic used within my run_analysis.r script***

1.) Read in relevant datasets (x+ytraining, x+ytest,subjecttest,subjecttrain,activity,features) from UCI HAR zip - Note: not all data sets in the file were needed    for this assignment

2.) Name columns for each dataset

3.) Search for only variables with Mean or Std within the features file and and subset the xtrain and xtest datasets on those values

4.) Bind subject, x and y test datasets

5.) Bind subject, x and y train datasets

6.) Bind test and train datasets 

7.) Join Activity label dataset with Binded dataset on y file values

8.) Use melt to reshape data set for definition of ID variables and measure variables. ID variables are subject and activity where the measure variables are the columns with mean or std from step 3

9.)  Take dataset from step 8 and create a second, independent tidy data set with the average of each variable for each activity and each subject using the dcast function from the reshape2 library

10.) Output Summary_data as text file

***The following is a listing of variables and files used in my run_analysis.r script***

**Files**
activity_labels.txt, y_test.txt, 
y_train.txt X_test.txt X_train.txt, 
features.txt, subject_test.txt, 
subject_train.txt

**Variables**

* Labels: Activity labels text file as dataset 

* ytest and ytrain: ytest and ytrain text files as datasets

* xtest and xtrain: xtest and xtrain text files as datasets

* subtest and subtrain: subject test and subject train text files as datasets

* features: feature text file containing feature labels as a dataset 

* extract_var: define concatenated string for the column filter variables which are mean and std

* extract: new dataset using grepl to return logical on filter variables in extract_var

* test: binding of x and y test datasets and subject test dataset 

* train: binding of x and y training datasets and subject training dataset 

* tandtdata: binding of test and train datasets

* all_data: tandtdataset merged with activity labels on the y values column (Activity_ID)

* meltlabel: define concatenated string of Id variables for Melt reshape

* all_melt: reshape all_data with id and measure variables defines to further summarize

* summary_data: Use dcast function to summarize dataset on activity and subject for each sensor
measurement variable which only includes mean and std measurements




