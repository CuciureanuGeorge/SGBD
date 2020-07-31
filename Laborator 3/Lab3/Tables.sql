-- TABELE

CREATE TABLE T1(
	ID int identity(1,1) primary key,
	[Telephone] varchar(20) not null,
);

CREATE TABLE T2(
	ID int identity(1,1) primary key,
	[Telephone] varchar(20) not null,
);

CREATE TABLE T1_T2(
	T1ID int foreign key references T1(ID),
	T2ID int foreign key references T2(ID)
);

CREATE TABLE [Log](
	Number int identity(1,1) primary key,
	[Description] varchar(250)
);

