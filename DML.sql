use Covid19InformationSys

INSERT INTO Division(DivisionName)
VALUES('DHAKA'),('BARISHAL'),('CHITTAGONG'),('KHULNA'),('RAJSHAHI'),('RANGPUR'),('SYLHET'),('MYMENSING')

INSERT INTO District(DistrictName)
VALUES('DHAKA'),('GAZIPUR'),('NAYANGONJ'),
('BARISAL'),('BHOLA'),('PATUAKHALI'),
('COXBAZAR'),('FENI'),('NOAKHALI'),
('JESSORE'),('SHATKHIRA'),('KUSTIA'),
('BOGRA'),('PABNA'),('SIRAJGONJ'),
('DINAJPUR'),('RANGPUR'),('GAIBANDHA'),
('SYLHET'),('SUNAMGONJ'),('HABIGONJ'),
('MYMENSING'),('NETROKONA'),('JAMALPUR')

insert into Hospital(HospitalName,HospitalAddress,test,year,Testposative,Testnagetive,isolated,revoerd,Death)
values
('IEDCR','DHAKA',1800000,'2020',1500000,400000,60000,2000000,1500),
('TMC','GAZIPUR',12000,'2020',2000,8000,800,10000,170),
('MTMC','NARAYANGANJ',300000,'2020',10000,200000,40000,160000,400),

('FGFH','BARISAL',21000,'2020',1030,19320,300,11500,110),
('GGSH','BHOLA',34100,'2020',600,32000,315,531,25),
('BGSH','PATUAKHALI',16000,'2020',230,15220,15,14010,85),

('CGSH','COXBAZAR',4100,'2020',30,3020,300,3510,18),
('NGSH','FENI',2100,'2020',200,1820,1715,2000,65),
('FGSH','NOAKHALI',41000,'2020',630,39020,705,3800,210),

(' JMC', ' JESSORE ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
(' SGSH', ' SHATKHIRA ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
(' KGSH', ' KUSTIA ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ), 

(' SZMC', ' BOGRA ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
(' PGSH', ' PABNA ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
('SGSH ', ' SIRAHGONJ ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ), 

(' DNMC', ' DINAJPUR ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
(' RMC', ' RANGPUR ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ),
(' GGSH', ' GAIBANDHA ', 48000 ,' 2020', 6000, 10000, 5000, 45000,300 ), 

(' SUMCH', ' SYLHET ', 48000 ,' 2020', 16000, 20000, 1500, 34000,200 ),
(' SGSH', ' SUNAMGONJ ', 2000 ,' 2020', 200, 1300, 5000, 1000,80 ),
(' HGSH', ' HABIGANJ ', 8000 ,' 2020', 200, 70000, 100, 5000,30 ), 

(' MMC', ' MYMENSING ', 48000 ,' 2020', 6000, 10000, 5000, 42000,200 ),
(' NGSH', ' NETROKONA', 2000 ,' 2020', 100, 1500, 10, 1800,300 ),
(' NGSH', ' JAMALPUR ', 1400 ,' 2020', 276, 1000, 68, 1200,39)

insert into Vaccine(VaccineName,Agelimit,doses)
VALUES
('sinovac',18,3),
('J&J',40,1),
('oxfordastra',40,3),
('phaizer',20,3)

INSERT INTO Analysis(DivisionID,DistrictId,HospitalID,VaccineId,populationnumber)
VALUES
(1,1,1,4,36050830),
(1,2,2,2,1400000),
(1,3,3,3,101300),
(2,4,1,2,182300),
(2,5,2,3,1057000),
(2,6,3,1,197900),
(3,7,1,2,179900),
(3,8,2,3,1754000),
(3,9,3,4,180000),
(4,10,1,4,120000),
(4,11,2,3,32000),
(4,12,3,4,220000),
(5,13,1,2,140000),
(5,14,2,4,290000),
(5,15,3,1,120080),
(6,16,1,4,220000),
(6,17,2,3,233000),
(6,18,3,1,360000),
(7,19,1,2,120000),
(7,20,2,3,120000),
(7,21,3,4,130000),
(8,22,1,3,160000),
(8,23,2,4,150000),
(8,24,3,3,150000)
----- join query----
select AnalysisID,DIVISIONNAME,DISTRICTNAME,populationnumber ,year,HospitalName,test,Testposative,Testnagetive,isolated,revoerd,Death,VaccineName,agelimit,doses
from Analysis a join DIVISION d on a.DIVISIONID=d.DIVISIONID
join DISTRICT ds on ds.DISTRICTID=a.DISTRICTID
join Hospital h on h.HospitalID=a.HospitalID
join Vaccine v on v.VaccineId=a.VaccineId
---self join to find District that have got same Vaccine----
SELECT A.HospitalName AS HospitalName1, B.HospitalName AS HospitalName2, A.Death
FROM Hospital A, Hospital B
WHERE A.HospitalID <> B.HospitalID
AND A.Death = B.Death
ORDER BY A.Death;

--- subquery to find the District-----
SELECT VaccineName,doses
FROM vaccine
WHERE NOT EXISTS (
  SELECT *
  FROM Vaccine
  WHERE VaccineId = 
);




-- cte Fetch latest available per  data from Hospital---

WITH Covid19 AS
   ( SELECT HospitalId,
            year,
            Death,
            Testposative,
            ROW_NUMBER() OVER (PARTITION BY HospitalId  ORDER BY Death DESC) as Isolated
     FROM Hospital)
SELECT HospitalID,
       year,
       Death,
       Testposative,
	   Isolated
       
FROM Hospital
WHERE HospitalAddress= 'DHAKA'





select * from Division
select * from District
select * from Hospital
select * from Analysis
select * from Vaccine

