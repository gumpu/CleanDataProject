

This dataset is based on the dataset "Human Activity Recognition Using Smartphones Dataset Version 1.0"
that can be found at: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

This dataset contains an aggregated subset of the data from the original dataset. 

The following steps were performed:
1. From both the training- and test set the features and labels were combined
   (X and y dataset).
2. From both the training- and test set only those features
   were chosen that either had "mean" or "std" in their name.
   This was done with the aid of the column numbers and feature names
   in the file `features.txt` from the original dataset.
3. The reduced training- and test set were combined into a total set
4. The label (called activity) contains an activity number, each number in the
   dataset was replaced by a descriptive name. For the names in the file
   `activity_labels.txt` from the orignal dataset was used.


