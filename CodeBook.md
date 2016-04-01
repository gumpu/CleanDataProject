# Code Book

This dataset is based on the dataset "Human Activity Recognition Using Smartphones Dataset Version 1.0"
that can be found at: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

This dataset contains an aggregated subset of the data from the original dataset. 

The following steps were performed:

1.  From both the training- and test set the features and labels were combined
    (variables from the X and y dataset).

2.  From both the training- and test set only those features
    were chosen that either had "mean" or "std" in their name (ignoring case).
    This was done with the aid of the column numbers and feature names
    from the file `features.txt` from the original dataset.

3.  The reduced training- and test set were combined into a single set

4.  The variable `activity` (label) contains an activity number. Each activity
    number in the dataset was replaced by a descriptive name. For this the
    names from the file `activity_labels.txt` from the original dataset were used.

5.  All feature were aggregated by activity and their mean was computed.


All variables are listed in `features.txt`. These are all numerical.

The variable `activity` can have the following values: WALKING, WALKING_UPSTAIRS,  WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

## Domain and Meaning

The variables/features in the original set were derived as follows: (quoting
from `feature_info.txt` from the original dataset)

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz.
Then they were filtered using a median filter and a 3rd order low pass
Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass
Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived
in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also
the magnitude of these three-dimensional signals were calculated using the
Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain
signals). 

These signals were used to estimate variables of the feature vector for each
pattern:  '-XYZ' is used to denote 3-axial signals in the X, Y and Z
directions.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean



