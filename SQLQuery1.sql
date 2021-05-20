create table BPM(bm_id int primary key, bm_name varchar(15), sex varchar(5));
create table Reg_Staff(rs_id int primary key, rs_name varchar(15), sex varchar(5));
create table District(dis_id int primary key,dis_name varchar(15));
create table DiseaseR(drecog_id int primary key, drecog_name varchar(15), sex varchar(5));
create table BloodR(rId int primary key, sex varchar(5), age int, r_regdate date, rName varchar(20), b_qnty int, rb_grp varchar(5), rs_id int, dis_id int,bm_id int, foreign key(bm_id) references BPM(bm_id), foreign key(rs_id) references Reg_Staff(rs_id), foreign key(dis_id) references District(dis_id));
create table BloodS(b_group varchar(5), sample_no int primary key, status varchar(5), drecog_id int, bm_id int, foreign key(bm_id) references BPM(bm_id), foreign key(drecog_id) references DiseaseR(drecog_id));
create table Donar(dName varchar(15), dId int primary key, sex varchar(5), age int, dreg_date date, rs_id int, dis_id int, db_grp varchar(5),foreign key(rs_id) references Reg_Staff(rs_id),foreign key(dis_id) references District(dis_id));
create table Hos1(hId int primary key, hName varchar(15), dis_id int, bm_id int, foreign key(bm_id) references BPM(bm_id), foreign key(dis_id) references District(dis_id));
create table Hos2(hId int, hb_grp varchar(5), db_qnty int, foreign key(hId) references Hos1(hId));

select * from Hos2;
sp_tables BPM;
insert into BPM values(6,'Deepa','F');
insert into BPM values(36,'Mehrab','M');
insert into BPM values(47,'Urmi','F');
insert into BPM values(74,'Dinar','M');

insert into Reg_Staff values(104,'Bushra','F');
insert into Reg_Staff values(105,'Arafat','M');
insert into Reg_Staff values(730,'Shila','F');
insert into Reg_Staff values(740,'Ony','M');
insert into Reg_Staff values(760,'Tania','F');
insert into Reg_Staff values(763,'Sonia','F');
insert into Reg_Staff values(793,'Sushmita','F');

insert into District values(10,'Dhaka');
insert into District values(20,'Khulna');
insert into District values(30,'Rajshahi');
insert into District values(40,'Chittagong');
insert into District values(50,'Barishal');
insert into District values(60,'Sylhet');
insert into District values(70,'Rangpur');

insert into DiseaseR values(401,'Jamil','M');
insert into DiseaseR values(501,'Mila','F');
insert into DiseaseR values(601,'Helal','M');
insert into DiseaseR values(801,'Shila','F');

insert into BloodR values(44,'M',23,'8-Jan-2010','Tanmay',1,'A+',793,10,6);
insert into BloodR values(87,'F',22,'2-Jan-2010','Swapnil',2,'B+',763,10,36);
insert into BloodR values(88,'M',23,'1-Jan-2010','Shohag',1,'A+',760,10,47);
insert into BloodR values(90,'F',24,'5-Feb-2010','Farzana',1,'O+',793,20,74);

insert into BloodS values('A+',305,'No',601,36);
insert into BloodS values('A+',401,'Yes',801,6);
insert into BloodS values('B+',405,'Yes',801,47);
insert into BloodS values('O+',202,'Yes',501,74);

insert into Donar values('Nasif',3,'M',23,'2-Jan-2010',105,10,'A+');
insert into Donar values('Nimi',7,'F',22,'2-Jan-2010',104,10,'B+');
insert into Donar values('Jenifer',10,'F',22,'1-Jan-2010',793,10,'O+');
insert into Donar values('Tanzima',14,'F',23,'1-Jan-2010',760,30,'A+');
insert into Donar values('Kaniz',16,'F',22,'3-Jan-2010',740,30,'B+');

insert into Hos1 values(910,'Dhaka Medical',10,6);
insert into Hos1 values(920,'Khula Medical',20,36);
insert into Hos1 values(930,'Rajshahi Hosp.',30,74);
insert into Hos1 values(940,'Chittagong Med',40,47);

insert into Hos2 values(910,'O+',30);
insert into Hos2 values(920,'B+',50);
insert into Hos2 values(930,'A+',10);
insert into Hos2 values(940,'O+',20);

select sample_no, b_group from BloodS b,DiseaseR dr where b.drecog_id = dr.drecog_id AND drecog_name ='Shila' AND status = 'Yes';

select dId,dName,rName,rId from Donar d, BloodR br where db_grp = rb_grp AND d.dis_id = br.dis_id;

select dId,dName,rId,rName from Donar d, BloodR br, Reg_Staff where db_grp = rb_grp AND dreg_date = r_regdate AND d.rs_id = br.rs_id AND rs_name = 'Tania';

select rId, rName, h1.hId, hName from Hos1 h1, Hos2 h2, District d, BloodR br where h1.hId = h2.hId AND hb_grp = 'A+' AND h1.dis_id = d.dis_id AND dis_name = 'Dhaka' AND rb_grp = hb_grp AND br.dis_id = d.dis_id;

select dName, rName, dis_name from Donar d, BloodR br ,District ds where d.db_grp = 'A+' AND d.db_grp = br.rb_grp AND ds.dis_id = 10;

select d.dName, dId, rs_name from Donar d, Reg_Staff rs where d.rs_id = rs.rs_id AND rs.rs_id = 104;

select dName, age, dId from Donar d, Reg_Staff rs where d.rs_id = rs.rs_id AND rs_name = 'Bushra' UNION select dName, age, dId from Donar where db_grp = 'B+';

select hName, hId, bm_id, dis_id from Hos1 where bm_id not in (select bm_id from BPM where bm_id =6);

select count(sample_no) from BloodS where b_group = 'O+';

select dis_name from Donar d, District dr where d.dis_id = dr.dis_id group by dis_name; 

