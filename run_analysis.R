library(data.table)
setwd("D:\\Ghassan\\DS")
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "data.zip")
unzip("data.zip")
setwd("D:\\Ghassan\\DS\\UCI HAR Dataset")

trainFile<-list.files("train",full.names = TRUE)[-1]
testFile<-list.files("test",full.names = TRUE)[-1]
files<-c(trainFile,testFile)
data<-lapply(files,read.table,stringsAsFactor=FALSE,header=FALSE)
data1<-mapply(rbind,data[c(1:3)],data[c(4:6)])
data2<-do.call(cbind,data1)
featurenames<-fread(list.files()[2])
measurmeants<-grep("std|mean\\(\\)",featurenames$V2)+1
data3<-data2[,c(1,measurmeants,563)]

averagedata <- aggregate( . ~ subject + activity, data = data3, FUN = mean )

setwd("D:/Ghassan/DS/Getting-Cleaning-Data-Course-Project")

write.table( averagedata, "average.csv", row.names = FALSE )

