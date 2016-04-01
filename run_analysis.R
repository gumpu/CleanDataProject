rm(list=ls())

data_directory <- "UCI HAR Dataset"

testfeatures_path    <- file.path(data_directory, "test", "X_test.txt") 
testlabel_path       <- file.path(data_directory, "test", "y_test.txt") 
trainfeatures_path   <- file.path(data_directory, "train", "X_train.txt") 
trainlabel_path      <- file.path(data_directory, "train", "y_train.txt") 
feature_names_path   <- file.path(data_directory, "features.txt")
activity_labels_path <- file.path(data_directory, "activity_labels.txt")


feature_names <- read.table(feature_names_path, colClasses=c("numeric", "character"), header=FALSE)
colnames(feature_names) <- c("column", "name")
activity_labels <- read.table(activity_labels_path, colClasses=c("numeric", "character"), header=FALSE)
colnames(activity_labels) <- c("number", "label")

mean_features <- grepl("mean", feature_names$name, ignore.case=TRUE)
std_features  <- grepl("-std", feature_names$name, ignore.case=TRUE)
wanted_features <- std_features | mean_features

wanted_features_col  <- feature_names[wanted_features,"column"]
wanted_features_name <- feature_names[wanted_features,"name"]


read_set <- function(feature_path, label_path, wanted_features_col, wanted_features_name) {
    features  <- read.table(feature_path, colClasses="numeric", header=FALSE, strip.white=TRUE)
    features  <- features[, wanted_features_col]
    colnames(features) <- wanted_features_name
    thelabels <- read.table(label_path, colClasses="numeric", header=FALSE, strip.white=TRUE)
    colnames(thelabels) <- "activity"
    dataset <- cbind(features, thelabels)
}

testset  <- read_set(testfeatures_path, testlabel_path, wanted_features_col, wanted_features_name)
trainset <- read_set(trainfeatures_path, trainlabel_path, wanted_features_col, wanted_features_name)

total_set <- rbind(testset, trainset)
total_set$activity <- factor(activity_labels[total_set$activity, "label"])

tidy_set <- melt(total_set, id.vars=c("activity"))
tidy_set <- aggregate(value~activity+variable, tidy_set ,mean)

