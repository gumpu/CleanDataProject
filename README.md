# CleanDataProject

This repository contains a tidy dataset based on the dataset "Human Activity
Recognition Using Smartphones Dataset Version 1.0"

This dataset itself is called `mean_and_std_of_features_by_activity.txt`

A list of variable names is available in `features.txt`.

Both these files can be generated with `run_analysis.R`.

This R Script assumes the original data is available in the current directory
under the name `UCI HAR Dataset/`.

The steps taken to derive this dataset from the original dataset are
described in `CodeBook.md`.

The source code of `run_analysis.R` also contains detailed comments 
on how the script works.

The basic idea is the following. The original dataset contains
two files. One with the feature names and one with the activity
names. We read both these files and use the data to:

1. select the features that contain mean of std values.  
2. replace the activity numbers with activity names.

This is done for both the test data and training data.

In a final step the data is aggregates by activity, labels
are renamed, and the tidy dataset is written to disk.

