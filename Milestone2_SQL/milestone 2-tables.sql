create database Milestone2
create database test
create table Users (
ID int primary key identity ,
firstName varchar(50),
lastName varchar(50),
password varchar(50),
gender bit ,
email varchar(50) unique,
address varchar(50))

create table Instructor (
Id int primary key ,
rating decimal(3,2) default 0.0 ,
constraint ratingcheck check(rating between 0.0 and 5.0),
foreign key(id) references users )

create table UserMobileNumber(
Id int primary key ,
mobileNumber varchar(30),
constraint numbercheck check(mobileNumber not like '%[^0-9]%'),
foreign key(id) references users )

create table Student (
Id int primary key ,
gpa decimal(3,2) default 0.0,
constraint gpacheck check(gpa between 0.0 and 4.0),
foreign key(id) references users on delete cascade on update cascade)

create table Admin (
Id int primary key 
foreign key(id) references users)

create table Course(
id int primary key identity,
creditHours int,
name varchar(50),
courseDescription varchar(80),
price decimal (6,2),
content varchar(80),
adminId int references	Admin on delete cascade on update cascade,
instructorId int references Instructor on delete cascade on update cascade,
accepted bit)

create table Assignment (
cid int ,
number int ,
type varchar(50),
primary key(cid,number,type),
fullGrade int not null,
weight decimal(2,1) not null,
constraint weightcheck check (weight <100),
deadline datetime not null,
content varchar(80),
foreign key (cid) references Course on delete cascade on update cascade )

create table Feedback(
cid int,
number int identity,
primary key(cid,number),
comments varchar(80),
numberOfLikes int,
sid int references Student on delete cascade on update cascade,
foreign key (cid) references Course on delete cascade on update cascade)


create table Promocode(
code varchar(50) primary key ,
issueDate datetime not null,
expiryDate datetime not null,
discountamount decimal(4,2),
adminId int references Admin on delete cascade on update cascade
)

create table StudentHasPromocode(
sid int ,
code varchar(50) ,
primary key(sid,code),
foreign key (code) references Promocode on delete cascade on update cascade,
foreign key (sid) references Student on delete cascade on update cascade)

create table CreditCard(
number varchar(15) primary key ,
cardHolderName varchar(50),
expiryDate datetime,
cvv varchar(3))

create table StudentAddCreditCard (
sid int ,
creditCardNumber varchar(15) ,
primary key(sid, creditCardNumber),
foreign key (creditCardNumber) references CreditCard on delete cascade on update cascade,
foreign key (sid) references Student on delete cascade on update cascade)


create table StudentTakeCourse(
sid int,
cid int,
instId int,
primary key(sid,cid,instId),
payedfor bit,
grade decimal(6,3),
foreign key (sid) references Student on delete no action on update no action,
foreign key (instId) references Instructor on delete no action on update no action,
foreign key (cid) references Course on delete no action on update no action)


create table StudentTakeAssignment(
sid int,
cid int,
assignmentNumber int,
assignmentType varchar(50),
primary key(sid,cid,assignmentNumber,assignmentType),
grade decimal(4,2),
foreign key (cid,assignmentNumber,assignmentType) references Assignment on delete cascade  on update  cascade,
foreign key (sid) references Student on delete cascade on update cascade)

create table StudentRateInstructor (
sid int ,
instId int ,
primary key(sid,instId),
rate decimal(2,1),
constraint ratecheck check (rate between 0.0 and 5.0),
foreign key (sid) references Student on delete cascade on update cascade,
foreign key (instId) references Instructor on delete cascade on update cascade)

create table StudentCertifyCourse(
sid int,
cid int ,
primary key(sid,cid),
issueDate datetime not null,
foreign key (cid) references Course on delete cascade on update cascade,
foreign key (sid) references Student on delete cascade on update cascade,

)


create table CoursePrerequisiteCourse(
cid int,
prerequisiteId int,
primary key (cid,prerequisiteId),
foreign key (prerequisiteId ) references course on delete no action on update no action,
foreign key (cid) references Course on delete no action on update no action,
)

create table InstructorTeachCourse(
instId int,
cid int,
primary key(instId,cid),
foreign key (cid) references Course on delete no action on update no action,
foreign key (instId) references Instructor on delete no action on update no action)



