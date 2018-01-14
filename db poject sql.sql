create database contactdb;
 use contactdb;
CREATE TABLE contact (
  contact_id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  address varchar(45) NOT NULL,
  telephone varchar(45) NOT NULL,
  PRIMARY KEY (contact_id)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8

select * from contact;

insert into contact value(12,"amitha","ami@redifmail","india",3332223);
insert into contact value(13,"itha","mi@redifmail","india",333223);


update contact set address="usa" where contact_id =35;

CREATE TABLE organization (
  organization_id int(11) NOT NULL AUTO_INCREMENT,
  organizationname varchar(45) NOT NULL,
  organizationsalary int(45) NOT NULL,
  organizationdesignation varchar(45) NOT NULL,
  organizationtelephone varchar(45) NOT NULL,
  FOREIGN KEY (organization_id) REFERENCES contact(contact_id)
) 


select * from organization;

drop table organization;

insert into organization value(32,"orgnisha",10000,"manager",3332223);
insert into organization value(33,"orgmadhu",20000,"president",333213);
insert into organization value(32,"ram",2000,"predsient",333213);


CREATE TABLE School (
  studentid int(11) NOT NULL AUTO_INCREMENT,
  studentname varchar(45) NOT NULL,
  studentemail varchar(45) NOT NULL,
  studentaddress varchar(45) NOT NULL,
  studenttelephone varchar(45) NOT NULL,
  PRIMARY KEY (studentid)
);

insert into School value(01,"bharath","bharath@gmail.com","fremont",3332223);
insert into School value(02,"nisha","nisha@gmail.com","fresno",32223);
insert into School value(03,"smitha","nisha@gmail.com","fresno",32223);
insert into School value(04,"shobith","nisha@gmail.com","fresno",32223);
insert into School value(05,"usha","nisha@gmail.com","fresno",32223);
insert into School value(06,"praveen","nisha@gmail.com","fresno",32223);
insert into School value(07,"gurunath","nisha@gmail.com","fresno",32223);

select * from School;

CREATE TABLE TechnicalTeam (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  address varchar(45) NOT NULL,
  telephone varchar(45) NOT NULL,
  PRIMARY KEY (id)
);

insert into TechnicalTeam value(201,"roopa","rp@gmail.com","bangalore",323);
insert into TechnicalTeam value(202,"rashmi","rashmi@gmail.com","bangalore",301);
insert into TechnicalTeam value(203,"sanjana","sanj@gmail.com","mysore",320);
insert into TechnicalTeam value(204,"anjana","anjana@gmail.com","tumkur",313);
insert into TechnicalTeam value(205,"shubha","shubha@gmail.com","bombay",300);

select * from TechnicalTeam;

Select name from contact where name='carolina';

select distinct organizationname from organization, contact
where organization.organization_id=contact.contact_id
and (organization.organizationsalary>5000 or organization.organizationsalary>=10000);


select name from contact where contact_id NOT IN (select id from TechnicalTeam);

select organization.organizationname, max(organizationsalary)-min(organizationsalary) as salary
from organization join contact on contact.contact_id=organization.organization_id
group by organization.organization_id
order by salary desc;

select max(organization.organizationsalary)-min(organization.organizationsalary) from
(select avg(organization.organizationsalary) from organization join 
contact on organization.organization_id=contact.contact_id where contact.contact_id >30
group by organization.organization_id);

create procedure usp_GetEmployeesSalaryAbove35000()

  select organizationname
  FROM organization
  WHERE organizationsalary > 5000;

execute  usp_GetEmployeesSalaryAbove35000;


create procedure calculate_salary(nisha VARCHAR(20), maxsalary int)
    avgsalary int;
begin
  SELECT id INTO avgsalary FROM organization WHERE organizationname = nisha;
  INSERT INTO organization (organization_id, organizationname,organizationsalary,
  organizationdesignation,organizationtelephone) VALUES (21, "nisha",101,"new member",2232);
end setavgsalary;

CREATE TRIGGER trgAfterInsert ON [contactdb].[contact] 
FOR INSERT
AS
	declare @empid int;
	declare @empname varchar(100);
	declare @empemail varchar(100);
	declare @audit_action varchar(100);

	select @empid=i.contact_id from inserted i;	
	select @empname=i.name from inserted i;	
	select @empemail=i.email from inserted i;	
	set @address='Inserted Record -- After Insert Trigger.';

	insert into organisation
           (organisation_id,organisationname,organisationsalary,organisationdesignation,organisationtelephone) 
	values(@empid,@empname,"5000","trigger member",123321);

	PRINT 'AFTER INSERT trigger fired.'
GO