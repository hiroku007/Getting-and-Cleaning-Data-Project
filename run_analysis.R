##Downloading the file
data<-"smartphones.zip"
if (file.exists(data)!=TRUE) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", mode="wb", destfile=data)
}

##reading and storing all the relevant data
activity_labels<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/activity_labels.txt"))
features<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/features.txt"))
Trainset<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/train/X_train.txt"))
Testset<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/test/X_test.txt"))
Trainlabel<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/train/y_train.txt"))
Testlabel<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/test/y_test.txt"))
SubjectTest<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/test/subject_test.txt"))
SubjectTrain<-read.table(unzip("smartphones.zip", "UCI HAR Dataset/train/subject_train.txt"))

##naming the column names with their apporpriate measurement
colnames<-as.character(features$V2)
colnames(Testset)<-colnames; colnames(Trainset)<-colnames

##Keeping only the columns with the mean and std measurements
relevantTest<-c((grep("mean", names(Testset))),(grep("std", names(Testset))))
relevantTrain<-c((grep("mean", names(Trainset))), (grep("std", names(Trainset))))
relevantTest<-sort(as.numeric(relevantTest)); relevantTrain<-sort(as.numeric(relevantTrain))
Trainset<-Trainset[,relevantTrain];Testset<-Testset[,relevantTest]

##Appending columns with information on activity and Subject number
Testset<-cbind(SubjectTest, Testlabel, Testset);Trainset<-cbind(SubjectTrain, Trainlabel, Trainset)
names(Testset)[[2]]<-"Activity";names(Trainset)[[2]]<-"Activity"
names(Testset)[[1]]<-"Subject";names(Trainset)[[1]]<-"Subject"

##Substituting descriptive info on activities for numbers
Testset$Activity<-as.character(Testset$Activity);Trainset$Activity<-as.character(Trainset$Activity)
Testset$Activity<-gsub("1", "Walking", Testset$Activity)
Testset$Activity<-gsub("2", "Walking upstairs", Testset$Activity)
Testset$Activity<-gsub("3", "Walking downstairs", Testset$Activity)
Testset$Activity<-gsub("4", "Sitting", Testset$Activity)
Testset$Activity<-gsub("5", "Standing", Testset$Activity)
Testset$Activity<-gsub("6", "Laying", Testset$Activity)
Testset$Activity<-as.character(Testset$Activity);Trainset$Activity<-as.character(Trainset$Activity)
Trainset$Activity<-gsub("1", "Walking", Trainset$Activity)
Trainset$Activity<-gsub("2", "Walking upstairs", Trainset$Activity)
Trainset$Activity<-gsub("3", "Walking downstairs", Trainset$Activity)
Trainset$Activity<-gsub("4", "Sitting", Trainset$Activity)
Trainset$Activity<-gsub("5", "Standing", Trainset$Activity)
Trainset$Activity<-gsub("6", "Laying", Trainset$Activity)

##Merging the two datasets
FullData<-rbind(Testset, Trainset)

##Obtaining means and standard deviations by subject and activity
meandata<-aggregate(. ~ Activity+Subject, data=FullData, FUN=mean)
stddata<-aggregate(.~Activity+Subject, data=FullData, FUN=sd)
Finaldata<-merge(meandata, stddata, by=c("Subject","Activity"))

##Writing Table to file
write.table(Finaldata, file="Cleansmartphonedata.txt")