# Libraries used
library(dplyr)

# Read features 

feature <- read.table("/UCI HAR Dataset/features.txt")

feature_vect <- feature_list[,"V2"]

# Read X_train 

X_train <- read.table("/UCI HAR Dataset/train/X_train.txt", col.names=feature_vect,check.names = FALSE)

# Read y_train  
y_train <- read.table("/UCI HAR Dataset/train/y_train.txt",col.names = "Activity")

# Read in subject_train 
subject_train <- read.table("/UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")


# Read in X_test and assign column labels from 'feature_vect'.
X_test <- read.table("/UCI HAR Dataset/test/X_test.txt", col.names=feature_vector,check.names = FALSE)

# Read in y_test and assign column label "Activity"
y_test <- read.table("/UCI HAR Dataset/test/y_test.txt",col.names = "Activity")

# Read in subject_test and assign column label "Subject"
subject_test <- read.table(" /UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")

# Combine X_train and X_test to form df
df <- rbind.data.frame(X_train,X_test)

# Combine y_train and y_test to "Activity" column
activity <- rbind.data.frame(y_train,y_test)

# Combine subject_train and subject_test to "Subject" column
subject <- rbind.data.frame(subject_train,subject_test)


# Select column names with means.
df1 <- df[ , grep("mean\\(\\)", names(df), perl = TRUE ) ]

# Select column names with standard deviations.
df2 <- df[ , grep("std\\(\\)", names(df), perl = TRUE ) ]

# Combine the two dataframe 
.
Main_df <- cbind(df1,df2)
Main_df <- Main_df[,order(names(Main_df))]

# Add activity and subject vectors

Main_df <- cbind(activity,subject,final_df)


#the activities in the "Activities" column

Main_df$Activity[which(Main_df$Activity == 1)] ="WALKING"
Main_df$Activity[which(Main_df$Activity == 2)] ="WALKING_UPSTAIRS"
Main_df$Activity[which(Main_df$Activity == 3)] ="WALKING_DOWNSTAIRS"
Main_df$Activity[which(Main_df$Activity == 4)] ="SITTING"
Main_df$Activity[which(Main_df$Activity == 5)] ="STANDING"
Main_df$Activity[which(Main_df$Activity == 6)] ="LAYING"

#Main dt 

Main_df <- Main_df[order(Main_df$Subject, Main_df$Activity),]

# Calculate mean values for each of the columns
means <- suppressWarnings(aggregate(final_df,by = list(final_df$Activity,final_df$Subject),function (x) mean(as.numeric(as.character(x)))))

# Clean columns in the "means" dataframe.

means <- subset(means, select=-c(Activity,Subject))
names(means)[names(means)=="Group.1"] <- "Activity"
names(means)[names(means)=="Group.2"] <- "Subject"

#  create 'tidy' data
means <- means %>% select(Subject, everything())
write.table(means,file="tiddy_data.txt",row.name=FALSE)
