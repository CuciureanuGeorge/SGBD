exec sp_MSforeachtable "declare @name nvarchar(max); set @name = parsename('?', 1); exec sp_MSdropconstraints @name";
exec sp_MSforeachtable "drop table ?";
-- an executable that "iterates through every single table 
-- and "
--First it will drop the constraints of every single table automaticly
--and secondly it will delete the tables in the database

CREATE TABLE Gifts
	(
		GiftId int PRIMARY KEY NOT NULL IDENTITY(1,1),
		"Description" varchar(255) NOT NULL
	)

CREATE TABLE Adress1
	( 
		AdressId int PRIMARY KEY NOT NULL IDENTITY(1,1),
		StraBeName varchar(30) NOT NULL,
		StraBeNr int NOT NULL,
		StraBeLand varchar(20) NOT NULL,
		StraBeStadt varchar(20)  NOT NULL
	);

CREATE TABLE Applicants
	(
		ApplicantId int PRIMARY KEY NOT NULL IDENTITY(1,1),
		ApplicantName varchar(50) NOT NULL,
		ApplicantJobRequest varchar(50) NOT NULL,
		ApplicantPhoneNr varchar(15) NOT NULL,
		AdressId int,
		--CONSTRAINT  FK_ADDRESS_APPLICANTS FOREIGN KEY (AdressId) REFERENCES Adress1(AdressId) ON DELETE SET NULL ON UPDATE CASCADE,
		dob date NOT NULL
	);

Alter table Applicants add constraint FK_ADDRESS_APPLICANTS FOREIGN KEY (AdressId) references  Adress1(AdressId) on delete set null on update cascade

--when we put constraints in the database we have CONSTRAINT-the name-FOREIGN KEY-(the reference in the present table)
--then we have REFERENCES (the referencing table) and in "(the referencing attribute)"--we put
--then the explicit constraints--DELETE SET "NULL" or CASCADE or UPDATE CASCADE-that's to cascade the updates
--through the tables

CREATE TABLE Manager1
	(
	 ManagerId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	 ManagerName varchar(255) NOT NULL,
	 ManagerArea varchar(15) NOT NULL,
	 ManagerPhone varchar(10) NOT NULL,
	 AdressId int,
	 CONSTRAINT  FK_ADDRESS_MANAGER1 FOREIGN KEY (AdressId) REFERENCES Adress1(AdressId) ON DELETE SET NULL ON UPDATE CASCADE,
	 dob date NOT NULL
	 );

SELECT * FROM Manager1

CREATE TABLE Developer1
	(
	 DevId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	 DevName varchar(255) NOT NULL,
	 DevTyp varchar(255) NOT NULL,
	 DevPhone varchar(10) NOT NULL,
	 ManagerId int 
	 CONSTRAINT FK_MANAGER1_DEVELOPER1 FOREIGN KEY(ManagerId) REFERENCES Manager1(ManagerId) ON DELETE SET NULL,
	 dob date NOT NULL,
	 nrPersonalProjects int,
	 GiftId int
	 CONSTRAINT FK_GIFTS_DEVELOPER1 FOREIGN KEY(GiftId) REFERENCES Gifts(GiftId) ON DELETE SET NULL,
	 Salary int NOT NULL
	);

CREATE TABLE Task1
	(
	 TaskId int PRIMARY KEY NOT NULL IDENTITY(1,1),
	 Title varchar(40) NOT NULL,
	 DescriptionTask varchar(80) NOT NULL,
	 Duration int NOT NULL
	);

CREATE TABLE Assigment1
	(
	 DevId int NOT NULL
	 CONSTRAINT FK_DEVELOPER1_ASSIGNMENT1 FOREIGN KEY(DevId) REFERENCES Developer1(DevId)  ON UPDATE CASCADE,
	 TaskId int NOT NULL
	 CONSTRAINT FK_TASK1_ASSIGNMENT1 FOREIGN KEY(TaskId) REFERENCES Task1(TaskId) ON DELETE CASCADE  ON UPDATE CASCADE,
	 PRIMARY KEY(DevId,TaskId),
	 AssigmentStatus bit
	);
-- here we can have a foreign key constraint that's going badly !!loo up and delete SET 'NULL'
CREATE TABLE Unternehmen1
	(UnternehmenId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	 UnternehmenName varchar(255) NOT NULL,
	 UnternehmenStartJahr int NOT NULL,
	 AdressId int
	 CONSTRAINT FK_ADRESS1_UNTERNEHMEN1 FOREIGN KEY(AdressId) REFERENCES  Adress1(AdressId) ON DELETE SET NULL ON UPDATE CASCADE
	 );

CREATE TABLE Hr1
	(HrId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	 HrName varchar(255) NOT NULL,
	 HrPhone varchar(10) NOT NULL,
	 ApplicantsRecruited int NOT NULL,
	 UnternehmenId int 
	 CONSTRAINT FK_UNTERNEHMEN1_HR1 FOREIGN KEY(UnternehmenId) REFERENCES Unternehmen1(UnternehmenId) ON DELETE SET NULL ON UPDATE CASCADE,
	 dob date NOT NULL
	 );

CREATE TABLE Interview
	(
		HrId int NOT NULL
		CONSTRAINT FK_HR1_INTERVIEW FOREIGN KEY(HrId) REFERENCES Hr1(HrId) ON UPDATE CASCADE,
		ApplicantId int NOT NULL
		CONSTRAINT FK_APPLICANTS_INTERVIEW FOREIGN KEY(ApplicantId) REFERENCES Applicants(ApplicantId),
		PRIMARY KEY(HrId,ApplicantId),
		fullDate datetime NOT NULL
	);

CREATE TABLE Zentrale
	(ZentraleId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	 ZentraleTyp varchar(12) NOT NULL,
	 ZentraleHaushalt int NOT NULL,
	 ManagerId int 
	 CONSTRAINT FK_MANAGER1_ZENTRALE FOREIGN KEY(ManagerId) REFERENCES Manager1(ManagerId) ON DELETE SET NULL ON UPDATE CASCADE ,
	 HrId int 
	 CONSTRAINT FK_HR1_ZENTRALE FOREIGN KEY(HrId) REFERENCES Hr1(HrId),
	 UnternehmenId int  
	 CONSTRAINT FK_UNTERNEHMEN1_ZENTRALE FOREIGN KEY(UnternehmenId) REFERENCES Unternehmen1(UnternehmenId) ,
	 AdressId int 
	 CONSTRAINT FK_ADRESS_ZENTRALE FOREIGN KEY(AdressId) REFERENCES  Adress1(AdressId)  
	 );



--drop table "Version"

CREATE TABLE "Version"
(
	currentVersion int DEFAULT 0
);

insert into "Version"(currentVersion)
VALUES(0)


--Now we begin to insert values into tables
insert Adress1(StraBeName,StraBeNr,StraBeLand,StraBeStadt)
	Values
	('Ploilor',17,'Romania','Cluj'),
	('Plozilor',25,'England','Berlin'),
	('Lemnului',11,'Romania','Bucharest'),
	('Leclair',30,'France','Paris'),
	('Herr Maus',24,'Germany','Munchen'),
	('Castanilor',4,'Romania','Iasi'),
	('Tirnitei',55,'Sweeden','Minsk'),
	('Ger-Herr Kaus',45,'Germany','Koln'),
	('Brivitei', 215, 'China', 'Kong Hu')
	/*(10,'RO-Gherman','67','',''),
	(11,'FR-Eiffel','','',''),
	(12,'USA-Perfo','','',''),
	(13,'ROOOOO','','',''),
	(14,'Ro','','',''),
	(15,'Ger','','',''),
	(16,'E Lafayette','45','USA','Tallahassee'),
	(17,'Kings Rd','23','USA','Jacksonville'),
	(18,'Boulevard Bertrand','12','Franta','Caen'),
	(19,'Taranului','42','Romania','Bucuresti'),
	(20,'Enescu','55','Romania','Cluj-Napoca'),
	(21,'','','',''),
	(22,'','','',''),
	(23,'','','',''),
	(24,'','','','');*/

insert Applicants(ApplicantName,ApplicantJobRequest,ApplicantPhoneNr,AdressId, dob)
	Values
	('Marcus Cesar','Frontend Developer','18504049368',1, '10-20-1999'),
	('Kurtis Podrick','Database Writer','19047170781',2, '04-03-1989'),
	('Kris Pierre','Backend Developer','0781562785',3, '01-11-1978'),
	('Kate Winslet','Researcher','0740245657',3, '10-12-1978'),
	('Kate Austen','Economy Manager','0742651565',2, '11-08-1975');

insert Manager1(ManagerName, ManagerArea,ManagerPhone,AdressId, dob)
	Values
	('Jack Shepard', 'Developing','0731921568',5, '08-09-1997'),
	('Charlie Peace', 'Economy','0742588888',6, '09-12-1989'),
	('Hugo Reyes', 'Frontend','0758789123',5, '10-14-1976'),
	('Sun Kwon', 'Backend','0731456654',7, '07-28-1983'),
	('Jin Kwon', 'Client-Relation','0749739053',4, '06-15-1983'),
	('Juliette Beauford', 'Research','0731921571',4, '04-09-1988');

insert Gifts("Description")
	values
	('Mouse'),
	('Desktop'),
	('Boxes'),
	('Smart watch'),
	('Wifi car'),
	('Laptop'),
	('wireless headphones'),
	('cable earphones')

insert Developer1(DevName,DevTyp,DevPhone,ManagerId, dob, nrPersonalProjects, GiftId, Salary)
	Values
	('Pam Kling','Software Engineer','2025550154',3, '11-14-1976',3,1,32000),
	('Eric Northman','Technical Manager','2025550194',3, '10-15-1993',4,2,24000),
	('Bill Phill','Software Engineer','2025550158',2, '09-03-1990',5,3,30000),
	('Jack Dawson','Data base Administrator','2025550183',5, '10-11-1980',6,6,16000),
	('Matthew Fox','Python Dev','2025550122',2, '01-01-2002',9,3,15000),
	('Evangeline Lilly','Data base Administrator','2095550152',6, '01-21-1998',10, 1,50000),
	('Lorena Adams','Frontend','2025550108',2, '04-05-1977',NULL,5,45000),
	('Krista Cook','Backend','2025550175',3, '11-30-1986',NULL,6,9000),
	('Catherine Pierce','Security Engineer','2025550130',3, '09-09-1999',7,NULL,8000),
	('Damon Salvatore','Python Dev','2025550140',6, '07-06-2000',3,1,28000),
	('Diana Balog','Frontend','2025550151',1, '09-19-1980',1,2,12000),
	('George Cuciureanu','Software Engineer','2025550100',4, '11-13-1968',9,4,21000);


insert Task1(Title,DescriptionTask, Duration)
	Values
	('DivideEtImpera','Just an algorithm to sort things out 😉', 13),
	('Research for Developing','Constructing new performing algorithms', 9),
	('Trash','Taking the trash out(irrelevant to work),someone needs to do it', 7),
	('Clients Expectations','Team-leader making sure everything is ok', 3),
	('Database','Perform updates on databases,making sure everything is ok', 2),
	('Compute sum of even numbers', 'Basic Math knowledge', 1);


insert Assigment1(DevId,TaskId,AssigmentStatus)
	Values
	(1,1,0),
	(2,4,1),
	(1,2,1),
	(4,6,1),
	(5,1,1),
	(6,4,1),
	(6,3,1),
	(3,5,1),
	(9,3,1),
	(1,6,1),
	(11,5,1),
	(12,2,1);


insert Unternehmen1(UnternehmenName,UnternehmenStartJahr,AdressId)
	Values
	('Genpact',1970,6),
	('Endava',1981,1),
	('Evolving',1999,2),
	('NTT',2001,3),
	('Auspicious',1998,5);

insert Hr1(HrName,HrPhone,ApplicantsRecruited,UnternehmenId, dob)
	Values
	('Loredana Marc','0745923123',1,1, '10-19-1989'),
	('Tina Turner','2353869201',2,2, '12-31-1997'),
	('Lori Grimes','4856125872',3,3, '06-06-2000'),
	('Andrea Bennet','1057125323',4,1, '03-09-1997'),
	('Maggie Green','0975923123',5,2, '09-10-1995'),
	('Emily Kinney','2353189201',6,5, '11-21-1987'),
	('Tara Mudford','4856225872',7,5, '12-05-1988'),
	('Cyndi Campbell','1053125323',8,4, '10-17-1987'),
	('Maya Morgenstein', '0786456781', 1, 3, '11-10-1976');
	

insert Interview(HrId,ApplicantId,fullDate)
	Values
	(1,1,'10-20-2019 15:10:03'),
	(2,2,'03-31-2019 13:00:00'),
	(3,3,'10-07-2019 09:30:00'),
	(4,4,'01-15-2019 19:37:20'),
	(5,5,'05-05-2016 17:15:00');




insert Zentrale(ZentraleTyp,ZentraleHaushalt,ManagerId,HrId,UnternehmenId,AdressId)
	Values -- 5 man 8 hr 5 unth 8 addr
	('Economy',1000,1,2,1,1),
	('Developing',4500,2,3,2,1),
	('Realtions',1234,1,5,3,3),
	('Backend',3500,4,6,4,3),
	('Database',9000,5,8,5,5),
	('Frontend',3000,3,1,5,4),
	('Algorithmic',2000,4,7,3,5),
	('Client Side',3000,3,3,2,2);



/*--This selects
SELECT * 
FROM Unternehmen1 WHERE UnternehmenStartJahr<=2000;*/

-- Standard Syntax

/*UPDATE Unternehmen1
SET UnternehmenName='Lava Cake'
WHERE UnternehmenName='Endava';

--an update statement
UPDATE Unternehmen1
SET UnternehmenName='Endava'
WHERE UnternehmenName='Lava Cake';*/
--reupdate to do everything correctly

-- delete 
-- delete all the tasks that must perform computations and have a duration < 2 hours ( a task performs computations if the word 'compute' is in the title



DELETE 
FROM Task1 
WHERE Task1."Duration" < 2 AND LOWER(Task1.Title) LIKE '%comput%'

-- delete all the addresses where the number is in [200, 300]
DELETE 
FROM Adress1
WHERE StraBeNr BETWEEN 200 AND 300

DELETE
FROM Gifts
WHERE "Description" LIKE '%phones%'




--update
-- give all the devs a gift by default if they don't have one
UPDATE Developer1
SET GiftId=3
WHERE GiftId IS NULL


-- Restitue the previous state
UPDATE Developer1
SET GiftId=NULL
WHERE GiftId = 3


-- update the street name into the correct one
UPDATE Adress1
SET StraBeName='Plopilor'
WHERE StraBeName IN ('Ploilor', 'Plozilor')



-- Join Hr1, Zentrale, Interviews (inner join)
SELECT H.HrName AS "Name", Z.ZentraleTyp AS "Type", I.fullDate as "Program"
FROM Hr1 H
JOIN Zentrale Z ON H.HrId = Z.HrId
JOIN Interview I ON H.HrId = I.HrId


-- Join Manager, Dev and Gifts (Mannager,Dev->Inner join; Dev,Gifts->left outer join) 
-- We've used left join because we want to display even the devs who have no gift (NULL GiftId)
SELECT M.ManagerName AS 'Manager Name', D.DevName AS 'Dev Name', G."Description" AS 'Gift'
FROM Developer1 D
JOIN Manager1 M ON D.ManagerId=M.ManagerId
LEFT JOIN Gifts G ON D.GiftID = G.GiftId 


-- Join Hr1, Interview and Applicants(inner join again)
SELECT H.HrName, I.fullDate, A.ApplicantName
FROM Interview I
JOIN Hr1 H ON I.HrId = H.HrId 
JOIN Applicants A ON I.ApplicantId = A.ApplicantId


-- Join Zentrale, Unternehmen, Address ( take only the country ) (inner)
SELECT Z.ZentraleTyp, U.UnternehmenName, A.StraBeLand
FROM Zentrale Z
JOIN Unternehmen1 U ON Z.UnternehmenId = U.UnternehmenId 
JOIN Adress1 A ON U.AdressId = A.AdressId


-- Join Zentrale, Manager and Address ( take only the country ) (inner)
SELECT Z.ZentraleTyp, M.ManagerName, A.StraBeLand
FROM Zentrale Z
JOIN Manager1 M ON Z.ManagerId = M.ManagerId
JOIN Adress1 A ON M.AdressId = A.AdressId


-- Join Manager, Dev, Address ( take only the country)(inner)
SELECT M.ManagerName, D.DevName, A.StraBeLand
FROM Developer1 D
JOIN Manager1 M ON D.ManagerId = M.ManagerId 
JOIN Adress1 A ON M.AdressId = A.AdressId


-- Compute the average of the salary of all the devs
SELECT AVG(Salary)
FROM Developer1


-- Select the total duration of the tasks
SELECT SUM("Duration")
FROM Task1



-- Select the top 3 youngest dev
SELECT TOP 3 D.DevName, DATEDIFF(hour, D.dob, GETDATE())/8766
FROM Developer1 D
ORDER BY DATEDIFF(hour, D.dob, GETDATE())/8766.0


-- Select the age of oldest manager
SELECT MAX(DATEDIFF(hour, M.dob, GETDATE())/8766)
FROM Manager1 M


-- Count the nr of assignments for each dev(inner)
SELECT D.DevName, COUNT(D.DevId)
FROM Assigment1 A
JOIN Developer1 D ON A.DevID = D.DevId
GROUP BY D.DevId, D.DevName

SELECT D.DevName, D.ManagerId
FROM Developer1 D

SELECT M.ManagerName, M.ManagerId
FROM Manager1 M

SELECT M.ManagerName,M.ManagerId, COUNT(*) AS 'Nr devs'
FROM Developer1 D
JOIN Manager1 M ON D.ManagerId=M.ManagerId
GROUP BY D.ManagerId, M.ManagerName ,M.ManagerId

-- Compute the number of devs that;each manager who have < 35 years is responsible of  (an inner there)
SELECT M.ManagerName,M.ManagerId, COUNT(*) AS 'Nr devs'
FROM Developer1 D
JOIN Manager1 M ON D.ManagerId=M.ManagerId
where (DATEDIFF(hour, M.dob, GETDATE())/8766.0) < 35
GROUP BY D.ManagerId, M.ManagerName ,M.ManagerId
--HAVING D.ManagerId = (
--						SELECT MA.ManagerId
--						FROM Manager1 MA
--						WHERE MA.ManagerId=D.ManagerId AND (DATEDIFF(hour, MA.dob, GETDATE())/8766.0) < 35
--					)


-- Find how many software engineers are in the database
SELECT D.DevTyp, COUNT(*) AS 'Nr'
FROM Developer1 D
WHERE LOWER(DevTyp)='software engineer'
GROUP BY D.DevTyp
--HAVING LOWER(DevTyp) LIKE 'software engineer'


-- Select all the jobs that a dev has (no duplicates allowed)
SELECT DISTINCT D.DevTyp
FROM Developer1 D


--Select the Devs with the GIFTS that are not null and have personal Porojects > 3--
--SELECT D.DevName,D.GiftId
--FROM Developer1 D,Gifts G
--WHERE D.GiftId=G.GiftId and D.GiftId IS NOT NULL
--GROUP BY D.DevName,D.GiftId,D.nrPersonalProjects
--HAVING D.nrPersonalProjects=( SELECT)


----here here here here HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

--Devs that are before 10-15-1993
SELECT D.DevName,D.dob
FROM Developer1 D
GROUP BY D.DevName,D.dob
HAVING D.dob<'10-15-1993'


-- Select the dev name with the maximum salary
SELECT D.DevName, D.Salary
FROM Developer1 D
WHERE D.Salary > ALL	
				(	
					SELECT DE.Salary
					FROM Developer1 DE
					WHERE DE.DevId != D.DevId
				)


-- Select all the devs who have as a gift a mouse or a desktop
SELECT D.DevName
FROM Developer1 D
JOIN Gifts G ON D.GiftId = G.GiftId 
WHERE G."Description" = ANY (
								SELECT G."Description"
								FROM Gifts G
								WHERE LOWER(G."Description") = 'mouse' OR LOWER(G."Description") = 'desktop'
							)


-- Select the addresses of hr's and applicants
SELECT A.StraBeLand, A.StraBeStadt, A.StraBeName
FROM Hr1 H, Adress1 A
WHERE H.HrId = A.AdressId

UNION

SELECT A.StraBeLand, A.StraBeStadt, A.StraBeName
FROM Applicants AP, Adress1 A
WHERE AP.AdressId = A.AdressId


-- Select the devs who are > 25 years old and who have > 3 assignments
SELECT D.DevName
FROM Developer1 D
WHERE (DATEDIFF(hour, D.dob, GETDATE())/8766.0) > 25 

INTERSECT

SELECT D.DevName
FROM Developer1 D, Assigment1 A
WHERE A.DevId=D.DevId AND (
							SELECT COUNT(*)
							FROM Assigment1 AA
							WHERE AA.DevId=D.DevId
						  ) > 2


-- Select all the devs except those who work in python
SELECT D.DevName
FROM Developer1 D
EXCEPT
SELECT D.DevName
FROM Developer1 D
WHERE LOWER(D.DevTyp) LIKE 'python%'


-- Select all the devs who are not Technical Managers, Software Engineer or work in backed
SELECT D.DevName
FROM Developer1 D
WHERE LOWER(D.DevTyp) NOT IN ('software engineer', 'backend', 'technical manager')


--EXEC USP_Versioning @vers=0
--rollback sau sa se reexecute procedura



select * from Developer1 where DevId=2
select * from Gifts