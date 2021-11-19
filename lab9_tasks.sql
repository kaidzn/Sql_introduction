-- Database: "University"

CREATE TABLE Credits(
	cred_num int PRIMARY KEY,
	lect_hours int,
	lab_hours int,
	pract_hours int,
	ind_st_hours int,
	total_hours int
	);

CREATE TABLE Subjects(
	subj_id int PRIMARY KEY,
	subj_name varchar(20),
	cred_num int REFERENCES Credits (cred_num)
	);

CREATE TABLE Students(
	stud_id int PRIMARY KEY,
	fname varchar(20),
	lname varchar(20),
	bdate date,
	phnum int,
	email varchar(30),
	group_id int
	);

CREATE TABLE Groups(
	group_id int PRIMARY KEY,
	group_name varchar(10),
	headstud_id int REFERENCES Students(stud_id),
	major_id int
	);

ALTER TABLE Students ADD FOREIGN KEY(group_id) REFERENCES Groups(group_id);

CREATE TABLE Ed_process(
	proc_id int PRIMARY KEY,
	group_id int REFERENCES Groups(group_id),
	subj_id int REFERENCES Subjects(subj_id),
	term int
	);

CREATE TABLE Progress(
	progress_id int PRIMARY KEY,
	proc_id int REFERENCES Ed_process(proc_id),
	stud_id int REFERENCES Students(stud_id),
	rk1 int,
	rk2 int,
	rk_avg int,
	exam int,
	final int
	);

CREATE TABLE Teachers(
	teach_id int PRIMARY KEY,
	fname varchar(20),
	lname varchar(20),
	phnum int,
	email varchar(30),
	positions varchar(30),
	dep_id int
	);

CREATE TABLE Departments(
	dep_id int PRIMARY KEY,
	dep_name varchar(50),
	room int,
	phnum int,
	email varchar(30),
	headteach_id int REFERENCES Teachers(teach_id)
	);

ALTER TABLE Teachers ADD FOREIGN KEY(dep_id) REFERENCES Departments(dep_id);

CREATE TABLE Majors(
	major_id int PRIMARY KEY,
	major_name varchar(100),
	dep_id int REFERENCES Departments (dep_id)
	);

ALTER TABLE groups ADD FOREIGN KEY(major_id) REFERENCES Majors(major_id);

CREATE TABLE Classes(
	class_id int PRIMARY KEY,
	class_type varchar(15)
	);

CREATE TABLE Schedule(
	sch_id int PRIMARY KEY,
	proc_id int REFERENCES ed_process,
	class_id int REFERENCES classes,
	teach_id int REFERENCES teachers,
	room int,
	sch_time time,
	day_of_week varchar(5)
	);

INSERT INTO Departments VALUES (1,'CSSE&T',409,124525,'caf.csse@gmail.com',1),
(2,'IS',800,124525,'caf.is@gmail.com',2),
(3,'EM',200,124525,'caf.em@gmail.com',3);

INSERT INTO Majors VALUES (1,'CSSE',1),
(2,'RET',1);

INSERT INTO Groups VALUES (1,'CSSE-131',NULL, 1),
(2,'CSSE-132',NULL, 1),
(3,'CSSE-133',NULL, 1),
(4,'CSSE-134',NULL, 1),
(5,'CSSE-135',NULL, 1),
(6,'CSSE-136',NULL, 1),
(7,'CSSE-137',NULL, 1),
(8,'CSSE-138',NULL, 1);

INSERT INTO Students VALUES (1,'Shakhmardan','Abdiganiev',NULL,1234567,'abdiganiev@gmail.com',1),
(2,'Saulet','Abai',NULL,1234567,'abai@gmail.com',2), 
(3,'Alina','Achilova',NULL,1234567,'achilova@gmail.com',3), 
(4,'Tursyn','Adilkhan',NULL,1234567,'adilkhan@gmail.com',4),
(5,'Alisher','Asainov',NULL,1234567,'asainov@gmail.com',5),
(6,'Anuarkhan','Aimenov',NULL,1234567,'aimenov@gmail.com',6),
(7,'Almat','Akhat',NULL,1234567,'akhat@gmail.com',7),
(8,'Erkesh','Akkoshkarov',NULL,1234567,'akkoshkarov@gmail.com',8);

INSERT INTO Teachers VALUES (1,'Olga','Zvyaginceva',1234567,'zvyaginceva@gmail.com','Senior lecturer',1), 
(2,'Kairat','Sariyev',1234567,'sariyev@gmail.com','Senior lecturer',1),
(3,'Nazgul','Rakhimzhanova',1234567,'rakhimzhanova@gmail.com','Senior lecturer',1),
(4,'Lyudmila','Kozina',1234567,'kozina@gmail.com','Senior lecturer',1);

INSERT INTO Credits VALUES (1,15,15,0,15,45),
(2,15,30,0,45,90),
(3,15,30,15,60,120);

INSERT INTO Subjects VALUES (1,'Database Design',2),
(2,'Physics',3);

INSERT INTO Ed_process VALUES (1,1,1,4),
(2,2,1,4),
(3,3,1,4),
(4,4,1,4),
(5,5,1,4),
(6,6,1,4);    

INSERT INTO Progress VALUES (1,1,1,90,90,90,40,90),
(2,2,2,90,90,90,36,90),
(3,2,3,90,90,90,49,90);	

INSERT INTO Classes VALUES (1,'lecture'), 
(2,'lab'),
(3,'pract');  

INSERT INTO Schedule VALUES (1,1,1,4,901,'10:00:00','mon'),
(2,2,2,4,303,'08:00:00','mon');
--THE FIRST TASK
SELECT lname FROM Students
WHERE group_id IN(
    SELECT group_id FROM Groups
    WHERE major_id = (
         SELECT major_id FROM Majors
         WHERE major_name = 'CSSE')); 
--THE SECOND TASK
SELECT s.fname FROM Students s, Progress p
WHERE p.progress_id IN(
  SELECT final FROM Progress
	GROUP BY final
	having final > avg(final)
);
--THE THIRD TASK
SELECT t.lname FROM Teachers t, Departments d
WHERE d.dep_id =(
    SELECT dep_id FROM Departments
	where dep_name = 'CSSE&T' and
	dep_name = 'IS'
);
--THE FOURTH TASK
SELECT all s.lname FROM Students s, Progress p
WHERE p.progress_id IN(
   SELECT progress_id FROM Progress
	WHERE exam < 50
);
--THE FIFTH TASK
SELECT max(s.lname) FROM Students s, Teachers t
WHERE t.teach_id IN(
   SELECT teach_id FROM Teachers
	WHERE max(length(t.lname))
);

	

