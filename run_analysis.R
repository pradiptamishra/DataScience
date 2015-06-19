##Getting & Cleaning Data Project run_analysis.R

run_analysis<-function(){
library(plyr)
library(dplyr)


##Read the test data of first 6 columns to dataframes & add subject & activity data
testDF<-read.fwf("X_test.txt", widths=c(16, 16,16,16,16,16))
testActivityDF<-read.fwf("y_test.txt", widths=c(1))
testSubjectDF<-read.fwf("subject_test.txt", widths=c(1))
testDF<-cbind(testSubjectDF,testActivityDF,testDF)

##Read the train data of first 6 columns to dataframes & add subject & activity data
trainDF<-read.fwf("X_train.txt", widths=c(16, 16,16,16,16,16))
trainActivityDF<-read.fwf("y_train.txt", widths=c(1))
trainSubjectDF<-read.fwf("subject_train.txt", widths=c(1))
trainDF<-cbind(trainSubjectDF,trainActivityDF,trainDF)

##Merge the two dataframes
##df<-merge(testDF,trainDF,all=TRUE)
df<-rbind(testDF,trainDF)



##Rename the dataframe columns
names(df)[1]<-"Subject"
names(df)[2]<-"Activity"
names(df)[3]<-"MeanX"
names(df)[4]<-"MeanY"
names(df)[5]<-"MeanZ"
names(df)[6]<-"StdX"
names(df)[7]<-"StdY"
names(df)[8]<-"StdZ"

##replace the activity by description
oldvalues <- c("1", "2", "3", "4","5","6")
newvalues <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING","STANDING","LAYING")
df$Activity <- newvalues[ match(df$Activity, oldvalues) ]

##group by subject,activity
##df<-group_by(df,Subject,Activity)
df<-group_by(df,Activity,Subject)
SumDF<-summarise(df,MeanX = mean(MeanX,na.rm=TRUE),MeanY=mean(MeanY,na.rm=TRUE),MeanZ=mean(MeanZ,na.rm=TRUE)
     ,StdX=mean(StdX,na.rm=TRUE),StdY=mean(StdY,na.rm=TRUE),StdZ=mean(StdZ,na.rm=TRUE))

SumDF

}





