# Code for Tidy dataset and Tidy dataset2


# Reading the X_train file
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      header=FALSE,fill=TRUE)

# Reading the features list and assiging it as column names of X_train
x_features <- read.table(".\\UCI HAR Dataset\\features.txt",
                         header=FALSE)
x_names <- x_features[,2]
colnames(x_train)<- x_names

# Reading y_train (activity list) and assigning it as a factor variable with the activity label
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt",
                      header=FALSE,fill=TRUE)
y_train[,1] <- as.factor(y_train[,1])
levels(y_train[,1]) <- c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
colnames(y_train) <- c("activity")

# Reading subject_train and renaming col name to subject_id and assigning as factor variable
sub_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",
                            header=FALSE,fill=TRUE)
colnames(sub_train) <- c("subject_id")
sub_train[,1] <- as.factor(sub_train[,1])

# Merging Training dataset

train_data <- cbind(sub_train,y_train,x_train)

# Reading the X_test file
x_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt",
                      header=FALSE,fill=TRUE)

# Assiging features as column names of X_test
colnames(x_test)<- x_names

# Reading y_test (activity list) and assigning it as a factor variable with the activity labels 
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt",
                      header=FALSE,fill=TRUE)
y_test[,1] <- as.factor(y_test[,1])
levels(y_test[,1]) <- c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
colnames(y_test) <- c("activity")

# Reading subject_test and renaming col name to subject_id and assigning as factor variable
sub_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",
                        header=FALSE,fill=TRUE)
colnames(sub_test) <- c("subject_id")
sub_test[,1] <- as.factor(sub_test[,1])

# Merging Testing dataset
test_data <- cbind(sub_test,y_test,x_test)

# Merging Training and Testing Dataset
my_data <- rbind(train_data,test_data)

# Extracting measurements of mean and std
x <- names(my_data)
mean_std_col <- grep("-(mean)|(std)", x)
tidy_data <- my_data[,c(1,2,mean_std_col)]
meanFreq_col <- grep("meanFreq",names(tidy_data))
tidy_data <- tidy_data[,-(meanFreq_col)]

# Average of each variable with subject _id and activity
tidy_melt <- melt(tidy_data,id=c("subject_id","activity"))
tidy_data2 <- dcast(tidy_melt,subject_id+activity ~ variable, mean)

# writing tidy dataset
write.table(tidy_data2,"avg_data.txt")