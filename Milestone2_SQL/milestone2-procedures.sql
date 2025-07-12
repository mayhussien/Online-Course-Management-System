create proc studentRegister
@first_name varchar(20), @last_name varchar(20), @password varchar(20),@email varchar(50), @gender bit, @address varchar(10)
AS
insert into Users(firstName,lastName,password,email,gender,address) values(@first_name,@last_name,@password,@email,@gender,@address)
insert into Student(Id,gpa) values(scope_identity(),default)


go
create proc InstructorRegister
@first_name varchar(20), @last_name varchar(20), @password varchar(20),@email varchar(50), @gender bit, @address varchar(10)
AS
insert into Users(firstName,lastName,password,email,gender,address) values(@first_name,@last_name,@password,@email,@gender,@address)
insert into Instructor(Id,rating) values(scope_identity(),default)




go
create proc userLogin
@Id int,@password varchar(20),@Success bit output,@Type int output
AS
BEGIN
if(exists(select* from Users where Id=@Id and password=@password))
set @Success=1
else
BEGIN
set @Success=0
return set @Type = NULL
end
if(exists(select* from Student where Id=@Id))
set @Type=2
else if(exists(select* from Instructor where Id=@Id))
set @Type=0
else 
set @Type=1
END




go
create proc addMobile
@Id int,@mobile_number varchar(20)
AS
insert into UserMobileNumber(Id,mobileNumber) values(@Id,@mobile_number)



go 
create proc AdminListInstr
AS
select U.firstName, U.lastName
from Instructor I inner join Users U on I.id=U.id


go 
create proc AdminViewInstructorProfile
@instrId int
AS
select U.*,I.rating  from Instructor I inner join Users U on I.id=U.id
where I.Id=@instrId




go
create proc AdminViewAllCourses
AS
select name,creditHours,price,content,accepted from Course 



go
create proc AdminViewNonAcceptedCourses
AS
select name,creditHours,price,content from Course 
where accepted is NULL or accepted=0



go
create proc AdminViewCourseDetails
@courseId int
AS
select name,creditHours,price,content,accepted from Course 
where id=@courseId




go
create proc AdminAcceptRejectCourse
@adminId int,@courseId int
AS 
update Course
set accepted=1 ,  adminID=@adminId where id=@CourseId




go
create proc  AdminCreatePromocode
@code varchar(6), @issueDate datetime, @expiryDate datetime, @discount decimal(4,2), @adminId int
AS
insert into Promocode(code,issueDate,expiryDate,discountamount,adminId) values (@code, @issueDate, @expiryDate, @discount, @adminId )


go
 create proc AdminListAllStudents
 AS
 select U.firstName,U.lastName from Users U inner join Student S on U.ID=S.Id

 



 GO
 create proc  AdminViewStudentProfile
 @sid int
 AS 
 select U.firstName,U.lastName,U.gender,U.email,U.address,s.gpa from users U inner join student S on u.ID=s.Id where s.Id=@sid



 go
create proc  AdminIssuePromocodeToStudent
@sid int, @pid varchar(6)
AS
insert into StudentHasPromocode(sid,code) values(@sid,@pid) 



go
create proc InstAddCourse
@creditHours int, @name varchar(10), @price DECIMAL(6,2), @instructorId int
AS
insert into course(creditHours,name,price,instructorId) values (@creditHours, @name, @price, @instructorId)
insert into InstructorTeachCourse(instId,cid) values (@instructorId,scope_identity())


go
create proc UpdateCourseContent
 @instrId int, @courseId int, @content varchar(20)
 AS
 if(exists(select * from InstructorTeachCourse where cid=@courseId and instId=@instrId))
 update Course 
 set content=@content where id=@courseId 





 go
 create proc UpdateCourseDescription
 @instrId int, @courseId int, @courseDescription varchar(200)
 AS
 if(exists(select * from InstructorTeachCourse where cid=@courseId and instId=@instrId))
 update Course 
 set courseDescription= @courseDescription where id=@courseId 

 



 go
 create proc AddAnotherInstructorToCourse
@insid int, @cid int, @adderIns int
AS
Begin 
if(exists (select*from Course where instructorId=@adderIns and id=@cid))
 insert into InstructorTeachCourse (instId,cid) values (@insid,@cid)
else 
print 'not the instructor who manage the course or the course does not exist'
END



go
create proc InstructorViewAcceptedCoursesByAdmin
@instrId int
AS
select id,name,creditHours from Course where instructorId=@instrId and accepted=1



go
create proc DefineCoursePrerequisites
@cid int , @prerequsiteId int
AS 
Begin
if(@cid<>@prerequsiteId)
insert into CoursePrerequisiteCourse(cid,prerequisiteId) values (@cid,@prerequsiteId)
else
print'A course cannot be a prerequsite of itself'
END




go

create proc DefineAssignmentOfCourseOfCertianType
 @instId int, @cid int , @number int, @type varchar(10), @fullGrade int, @weight decimal(4,1), @deadline datetime, @content varchar(200)
 As
 Begin 
 if(exists(select*from InstructorTeachCourse where cid=@cid and instId= @instId))
 insert into Assignment(cid,number,type,fullGrade,weight,deadline,content) 
 values( @cid, @number, @type, @fullGrade, @weight, @deadline, @content)
 else 
 print 'instrctor does not teach course'
 END 

 
 
 go 
create proc updateInstructorRate
@insid int
AS
declare @temp decimal(3,1)
select @temp=AVG(rate) from StudentRateInstructor S
where S.instId=@insid
update Instructor
set rating=@temp 
where Id=@insid


 go
 create proc  ViewInstructorProfile
 @instrId int
 AS 
 select U.firstName,U.lastName,U.gender,U.email,U.address,I.rating,UM.mobileNumber
 from Users U inner join Instructor I on U.ID=I.Id
              inner join UserMobileNumber UM on I.Id=UM.Id
where U.ID=@instrId





go 
create proc InstructorViewAssignmentsStudents
@instrId int, @cid int
AS
BEGIN
If(exists(select* from StudentTakeCourse where instId=@instrId and cid=@cid))
select sid,cid,assignmentNumber,assignmenttype from StudentTakeAssignment
where cid=@cid
end



go
create  proc InstructorgradeAssignmentOfAStudent
 @instrId int, @sid int , @cid int, @assignmentNumber int, @type varchar(10), @grade decimal(5,2)
 AS
 BEGIN
If(exists(select* from StudentTakeAssignment where cid=@cid and sid=@sid and assignmentNumber=@assignmentNumber and assignmentType=@type)
and exists (select*from InstructorTeachCourse where instId=@instrId and cid=@cid))
update StudentTakeAssignment
set grade=@grade where assignmentNumber=@assignmentNumber and assignmentType=@type and sid=@sid and cid=@cid
end 


go
create proc ViewFeedbacksAddedByStudentsOnMyCourse
@instrId int, @cid int
AS
BEGIN
If(exists(select* from InstructorTeachCourse where instId=@instrId and cid=@cid))
select number,comments,numberOfLikes from Feedback
where cid=@cid
end




GO
create proc calculateFinalGrade
@cid int , @sid int , @insId int
AS
Create table temp(
grade1 decimal(5,2),
gradetotal1 int,
weight1 decimal(5,2),
sum1 as (grade1/gradetotal1) * weight1)
insert into temp
select  S.grade,A.fullGrade,A.weight
from StudentTakeAssignment S inner join Assignment A on S.cid=A.cid and S.assignmentNumber=A.number and S.assignmentType=A.type
where S.cid=@cid and S.sid=@sid
declare @sumall decimal (5,2) 
select @sumall=sum(sum1) from temp 
update StudentTakeCourse
set grade=@sumall where cid=@cid and sid=@sid and instId=@insId
drop table temp 


go
create proc  InstructorIssueCertificateToStudent
 @cid int , @sid int , @insId int, @issueDate datetime
 AS
 begin 
 if(exists(select * from StudentTakeCourse where cid=@cid and sid=@sid and grade>50) and exists(select*from InstructorTeachCourse where instId=@insId and cid=@cid))
 insert into StudentCertifyCourse (cid,sid,issueDate) values (@cid,@sid,@issueDate)
 else 
 print 'did not finish course'
 end


go
create proc viewMyProfile
@id int
AS
select U.*,S.gpa from Users U inner join Student S on U.id=S.id 
where S.Id=@id 



go 
create proc editMyProfile
@id int, @firstName varchar(10), @lastName varchar(10), @password varchar(10), @gender binary,
@email varchar(10), @address varchar(10)
AS
begin
if(@firstName is not null)
update Users
set firstName=@firstName
where ID=@id 
if(@lastName is not null)
update Users 
set lastName=@lastName
where ID=@id 
if(@password is not null)
update Users 
set password=@password
where ID=@id 
if(@gender is not null)
update Users
set gender=@gender
where ID=@id 
if(@email is not null)
update Users
set email=@email
where ID=@id 
if(@address is not null)
update Users
set address=@address
where ID=@id  
end 




go
create proc availableCourses
AS
select name from Course where accepted=1



go
create proc  courseInformation
@id int 
AS
select C.*,U.firstName,U.lastName from Course C inner join InstructorTeachCourse I on C.id=I.cid
                         inner join Users U on U.ID=I.instId
                         where C.id=@id and c.accepted=1


go 
create proc enrollInCourse
@sid INT, @cid INT, @instr int
AS
begin
if(exists(select* from InstructorTeachCourse where instId=@instr and cid=@cid) and exists(select*from Course where id=@cid and accepted=1))
insert into StudentTakeCourse(sid,cid,instId) values(@sid,@cid,@instr)
end




 go
 create proc  addCreditCard
 @sid int, @number varchar(15), @cardHolderName varchar(16), @expiryDate datetime, @cvv varchar(3)
 AS
 insert into CreditCard(number,cardHolderName,expiryDate,cvv) values(@number,@cardHolderName,@expiryDate,@cvv)
 insert into StudentAddCreditCard(sid,creditCardNumber) values(@sid,@number)



 go 
 create proc viewPromocode
 @sid int
 AS
select P.* from Promocode P inner join StudentHasPromocode S on P.code=S.code
where S.sid=@sid



go
create proc  payCourse
 @cid INT, @sid INT
AS
begin
if(exists(select* from StudentTakeCourse where sid=@sid and cid=@cid))
update StudentTakeCourse
set payedfor=1 where cid=@cid and sid=@sid
end




 go 
 create proc enrollInCourseViewContent
 @id int, @cid int
 AS
 BEGIN
 IF(exists(select* from StudentTakeCourse where sid=@id and cid=@cid))
 select id,creditHours,name,courseDescription,price,content from Course where id=@cid
 end 
 


 go
 create proc  viewAssign
  @courseId int, @Sid int
  AS
  BEGIN
  IF(exists(select* from StudentTakeAssignment where sid=@Sid and cid=@courseId))
  select* from Assignment where cid=@courseId
  END

  

  go
  create proc submitAssign
  @assignType VARCHAR(10), @assignnumber int, @sid INT, @cid INT
  As
  Begin
  if(exists(select* from Assignment where type=@assignType and number=@assignnumber))
  insert into StudentTakeAssignment(sid,cid,assignmentNumber,assignmentType) values(@sid,@cid,@assignnumber,@assignType)
  end 

  

  go
  create proc viewAssignGrades
   @assignnumber int, @assignType VARCHAR(10), @cid INT, @sid INT,
   @assignGrade INT output
   AS
   select @assignGrade=grade from StudentTakeAssignment where assignmentNumber=@assignnumber and assignmentType=@assignType and
   cid=@cid and sid=@sid

   

   go
   create proc viewFinalGrade
   @cid INT, @sid INT,
   @finalgrade decimal(10,2) output
   AS
   select @finalgrade=grade from StudentTakeCourse where cid=@cid and sid=@sid 

   

   go 
   create proc  addFeedback
    @comment VARCHAR(100), @cid INT, @sid INT
    AS
    begin
    if(exists(select* from StudentTakeCourse where cid=@cid and sid=@sid))
    insert into Feedback(cid,comments,sid) values(@cid,@comment,@sid)
    end

    

    go
    create proc rateInstructor
    @rate DECIMAL (2,1), @sid INT, @insid INT
    AS
    begin 
    if(exists(select* from StudentTakeCourse S  where S.sid=@sid and S.instId=@insid))
    insert into StudentRateInstructor(sid,instId,rate) values(@sid,@insid,@rate)
    end 

    
    go
    create proc viewCertificate
    @cid INT, @sid INT
    AS
    select* from StudentCertifyCourse where cid=@cid and sid=@sid

   