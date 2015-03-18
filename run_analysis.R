###############################################
# load package dplyr 
###############################################
require(dplyr)

###############################################
# Assign Files to variables
###############################################

DIR <- "UCI\ HAR\ Dataset"
feature_file <- paste(DIR, "/features.txt", sep = "")
activity_labels_file <- paste(DIR, "/activity_labels.txt", sep = "")
x_train_file <- paste(DIR, "/train/X_train.txt", sep = "")
y_train_file <- paste(DIR, "/train/y_train.txt", sep = "")
subject_train_file <- paste(DIR, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(DIR, "/test/X_test.txt", sep = "")
y_test_file  <- paste(DIR, "/test/y_test.txt", sep = "")
subject_test_file <- paste(DIR, "/test/subject_test.txt", sep = "")

###############################################
# Read and Merge the Training Data
###############################################

x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
training_data <- cbind(cbind(x_train, subject_train), y_train)

###############################################
# Read and Merge the Test Data
###############################################

x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)
test_data <- cbind(cbind(x_test, subject_test), y_test)

###############################################
# Combine the Training and Test Data
###############################################

combined_data <- rbind(training_data, test_data)

###############################################
# Add labels to the file to the combined data
###############################################
features <- read.table(feature_file, colClasses = c("character"))
collabels <- rbind(rbind(features, c(562, "Subject")), c(563, "Activity_ID"))[,2]
names(combined_data) <- collabels

###############################################
# Get all data related to mean and standard 
# deviation using grep function
###############################################
msdata <- combined_data[,grepl("mean|std|Subject|Activity_ID", names(combined_data))]

###############################################
# Join the Combined Data with the Activity 
# Labels file but Activity_ID
###############################################
activity_labels <- read.table(activity_labels_file, col.names = c("Activity_ID", "Activity_Label"))
msdata <- join(msdata, activity_labels, by = "Activity_ID", match = "first")
msdata <- msdata[,-1]

###############################################
# Rename some columns
###############################################
names(msdata) <- gsub('\\(',"",names(msdata))
names(msdata) <- gsub('\\)',"",names(msdata))
names(msdata) <- gsub('^t','Time',names(msdata))
names(msdata) <- gsub('^f','Freq',names(msdata))

###############################################
# Get the average of each activity and subject
###############################################
msdata = ddply(msdata, c("Subject","Activity_Label"), numcolwise(mean))
write.table(msdata, file = "tidydata.txt")
