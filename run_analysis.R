rm(list=ls()) # Makes finding bugs easier

require(reshape2)  # For melt and acast

data_directory <- "UCI HAR Dataset"

# The path names of all input files we are going to use.
testfeatures_path    <- file.path(data_directory, "test", "X_test.txt") 
testlabel_path       <- file.path(data_directory, "test", "y_test.txt") 
testsubject_path     <- file.path(data_directory, "test", "subject_test.txt") 
trainfeatures_path   <- file.path(data_directory, "train", "X_train.txt") 
trainlabel_path      <- file.path(data_directory, "train", "y_train.txt") 
trainsubject_path    <- file.path(data_directory, "train", "subject_train.txt")
feature_names_path   <- file.path(data_directory, "features.txt")
activity_labels_path <- file.path(data_directory, "activity_labels.txt")


# Read the feature names, these we are going to use as descriptive names
feature_names <- read.table(feature_names_path, colClasses=c("numeric", "character"), header=FALSE)
colnames(feature_names) <- c("column", "name")
# Read the activity labels. These were are going to use to replace the
# activity numbers
activity_labels <- read.table(activity_labels_path, colClasses=c("numeric", "character"), header=FALSE)
colnames(activity_labels) <- c("number", "label")

# We are only interested in features that contain a mean or a standard
# deviation.
# Create a logical vector to select all these from the features name table
mean_features <- grepl("mean", feature_names$name, ignore.case=TRUE)
std_features  <- grepl("-std", feature_names$name, ignore.case=TRUE)
wanted_features <- std_features | mean_features

# Get the column numbers for these features
wanted_features_col  <- feature_names[wanted_features,"column"]
# And their names.
wanted_features_name <- feature_names[wanted_features,"name"]


# Have to do the same thing twice, so why not make a function for it.
read_set <- function(feature_path, label_path, subject_path, wanted_features_col, wanted_features_name) {
    features  <- read.table(feature_path, colClasses="numeric", header=FALSE, strip.white=TRUE)
    # Select only those columns of the features we want
    features  <- features[, wanted_features_col]
    # And give them descriptive names
    colnames(features) <- wanted_features_name

    # Also read the label (activity number)
    thelabels <- read.table(label_path, colClasses="numeric", header=FALSE, strip.white=TRUE)
    # And give it a descriptive name too.
    colnames(thelabels) <- "activity"

    # Read subject
    thesubjects <- read.table(subject_path, colClasses="numeric", header=FALSE, strip.white=TRUE)
    colnames(thesubjects) <- "subject"

    # Combine features, label and subject
    dataset <- cbind(features, thelabels, thesubjects)
}


# Read and filter the test set
testset  <- read_set(testfeatures_path, testlabel_path, testsubject_path, wanted_features_col, wanted_features_name)
# Read and filter the training set
trainset <- read_set(trainfeatures_path, trainlabel_path, trainsubject_path, wanted_features_col, wanted_features_name)

# Combine both into a single set
total_set <- rbind(testset, trainset)
# Replace the activity number with the corresponding activity name, and make
# a factor out of it.
total_set$activity <- factor(activity_labels[total_set$activity, "label"])

# Compute per different activity the mean value of all the features/variables.
# (reshape is awesome!)
molten_set <- melt(total_set, id.vars=c("subject", "activity"))
tidy_set   <- dcast(molten_set, subject + activity~variable, mean)

# Add the word mean infront of each feature/variable name, as we computed the
# mean for each one.
feature_names <- colnames(tidy_set)
feature_names <- paste(rep("mean", length(feature_names)), feature_names, sep="-")
# Execpt for activity and subject
feature_names[1] <- "subject"
feature_names[2] <- "activity"
colnames(tidy_set) <- feature_names

# Now write the tidy dataset to disk
write.table(tidy_set, "mean_and_std_of_features_by_activity.txt", row.names=FALSE, quote=FALSE)
# And write a list of variable/feature names to.
write.table(feature_names, "features.txt", row.names=TRUE, col.names=FALSE, quote=FALSE)

