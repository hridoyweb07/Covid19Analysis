Drop Database Covid19InformationSys
create database Covid19InformationSys
on
(
name = 'Covid19InformationSys_Data_1',
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Covid19InformationSys _Data_1.mdf',
size = 25mb,
maxsize = 100mb,
filegrowth = 5%
)
log on(
name = 'Covid19InformationSys_Log_1',
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Covid19InformationSysB _Log_1',
size = 2mb,
maxsize = 50mb,
filegrowth = 1%
)
use Covid19InformationSys
CREATE TABLE Division(
DivisionID int not null primary key identity(1,1),
DivisionName Varchar(40)
)

CREATE TABLE District (
DistrictID int not null primary key identity(1,1),
DistrictName VARCHAR(50)
)
create table Hospital(
HospitalID int primary key identity(1,1),
HospitalName varchar (50),
HospitalAddress varchar (50),
test  decimal null,
[year] date,
Testposative  decimal(18,2),
Testnagetive  decimal(18,2),
isolated decimal(18,2),
revoerd  decimal(18,2),
Death  decimal(18,2)
)
 create table Vaccine(
 VaccineId int primary key identity(1,1) not null,
 VaccineName varchar(50),
 Agelimit int,
 doses varchar(50)
 )
Create table Analysis
 (
 AnalysisID int primary key not null identity(1,1),
 DivisionID int REFERENCES Division(DivisionID),
 DistrictID int REFERENCES District(DistrictID),
 HospitalID int references Hospital(HospitalID),
 VaccineId  int references Vaccine( VaccineId),
 populationnumber int
)

-----------------After trigger----------------- 
select * from Vaccine

Create table vaccinebekuptbl(
VaccineId int primary key identity(1,1) not null,
VaccineName varchar(50),
Agelimit int,
doses varchar(50),
UpdatedBy varchar(30),
UpdatedOn datetime
)
--------------After Trigger----------------
drop trigger tr_employeebackuptblrecord

Create Trigger tr_vaccinebekuptbl
on vaccine
after update, insert
as
begin
	insert into vaccinebekuptbl(VaccineName,Agelimit,doses,UpdatedBy,UpdatedOn)
	select i.VaccineName,i.Agelimit,i.doses,SUSER_SNAME(),getdate()
	from Vaccine t
	inner join inserted i on t.VaccineId=i.VaccineId
end
go 

insert into Vaccine(VaccineName,Agelimit,doses)
VALUES
('spotnic',19,3)

select * from Vaccine
select* from vaccinebekuptbl

----------instead of trigger---------
drop table Analysis_log
create table Analysis_log(
Id int identity (1,1) primary key,
AnalysisID int,
action varchar(50)
)
create trigger tr_Analysis_log
on Analysis
instead of delete 
as
begin 
declare @AnalysisID int
select @AnalysisID =deleted.AnalysisID
from deleted
if @AnalysisID=1
begin 
Raiserror('analysis 1 cannot be deleted',16,1)
Rollback
insert into Analysis_log values(@AnalysisID,'cannot be deleted')
end
else 
begin 
delete from Analysis where AnalysisID=@AnalysisID
insert into Analysis_log values(@AnalysisID,'insted of delete')
end
end
-------delete analysis id------
delete from Analysis where AnalysisID=1

create view viewtbl
as
select AnalysisID,DIVISIONNAME,DISTRICTNAME,populationnumber ,year,HospitalName,test,Testposative,Testnagetive,isolated,revoerd,Death,VaccineName,agelimit,doses
from Analysis a join DIVISION d on a.DIVISIONID=d.DIVISIONID
join DISTRICT ds on ds.DISTRICTID=a.DISTRICTID
join Hospital h on h.HospitalID=a.HospitalID
join Vaccine v on v.VaccineId=a.VaccineId
----showing view viewtbl----
select *from viewtbl

----------table value function-------
create function fn_tblvalue
()
returns table 
return
(
select AnalysisID,DIVISIONNAME,DISTRICTNAME,populationnumber ,year,HospitalName,test,Testposative,Testnagetive,isolated,revoerd,Death,VaccineName,agelimit,doses
from Analysis a join DIVISION d on a.DIVISIONID=d.DIVISIONID
join DISTRICT ds on ds.DISTRICTID=a.DISTRICTID
join Hospital h on h.HospitalID=a.HospitalID
join Vaccine v on v.VaccineId=a.VaccineId
)

--------showing tblvalue function-----
select * from fn_tblvalue();

-----------scaler value fn Office_in_out_details-----------
create function fn_sclearvalue()
returns int
begin
DECLARE @c int
select @c = COUNT(DivisionID) from Analysis;
return @c;
end
go
----------showing
select dbo. fn_sclearvalue();