
#---- Set Working Directory to text file location
setwd("~/DataSciTools/GetCleanData_Proj")

#---- Check if data.table non-base package is installed and if not install it 
if (!require("data.table")) {
  install.packages("data.table")
}
require("data.table")
if (!require("reshape2")) {
  install.packages("reshape2")
}


require("reshape2")

#------- Read in Datasets----------------#
#Read in: Labels
labels <-read.table("activity_labels.txt")

# Read in: Y test data and Y training data records
ytest <-read.table("y_test.txt")
ytrain <-read.table("y_train.txt")

# Read in: X test data and X training data records
xtest <-read.table("X_test.txt")
xtrain <-read.table("X_train.txt")

# Read in: Signal Variables for X data labels 
features <-read.table("features.txt")[,2]

# Load in subject data 
subtest <-read.table("subject_test.txt")
subtrain <-read.table("subject_train.txt")

# ---- Label all dataset columns-------------#
names(labels) <- c("Activity_ID", "Activity")

# Label Subject Columns
names(subtest) = "Subject_Id"
names(subtrain) = "Subject_Id"

# Label X dataset  columns
names(xtest) = features
names(xtrain) = features

# Label y dataset column
names(ytest)= "Activity_ID"
names(ytrain)= "Activity_ID"

#-- Extract mean and std columns from features
extract_var <- c("mean","std")
extract <- grepl(paste(extract_var,collapse="|"),features)

# filter columns on X datasets
xtest <- xtest[,extract]
xtrain <- xtrain[,extract]


#------Merge datasets ------------------------#

# Merge x,y and subject test datasets  by column

test <- cbind(as.data.table(subtest),ytest,xtest)

# Merge x, y and subject training datasets by column
train <- cbind(as.data.table(subtrain),ytrain,xtrain)

# Merge test and training datasets
tandtdata <- rbind(test,train)

# Join Activity Labels by ID from Y dataset
all_data <- merge(labels, tandtdata, by = "Activity_ID", all=TRUE)


#---Reshape dataset then summarize with mean and output final file ----# 

# Use Melt to identify id variables and measure variables so we can run the mean summary after
meltlabel <- c("Activity","Subject_Id")

all_melt <- melt(all_data, id = meltlabel, measure.vars= colnames(xtest))

# Output new data table 
summary_data  <- dcast(all_melt, Subject_Id + Activity ~ variable, mean)

#Write output file to text as same format as input files 

write.table(summary_data, file="summary_data.txt", row.name=FALSE)










