create database heytodo;
use heytodo;

create table user(
	id int not null auto_increment primary key,
	name varchar(50),
	lastname varchar(50),
	username varchar(50),
	email varchar(255),
	password varchar(60),
	image varchar(255),
	status int default 1,
	kind int default 1,
	created_at datetime
);

/**
* password: encrypted using sha1(md5("mypassword"))
* status: 1. active, 2. inactive, 3. other, ...
* kind: 1. root, 2. other, ...
**/

/* insert user example */
insert into user (name,username,password,created_at) value ("Administrator","admin",sha1(md5("admin")),NOW());


create table project(
	id int not null auto_increment primary key,
	name varchar(50),
	created_by int,
	foreign key (created_by) references user(id)
);

create table task(
	id int not null auto_increment primary key,
	title varchar(255),
	description text,
	finish_limit date,
	status int default 0,
	project_id int,
	created_by int,
	created_at datetime,
	foreign key (project_id) references project(id),
	foreign key (created_by) references user(id)
);

create table invite(
	id int not null auto_increment primary key,
	project_id int not null,
	invited_id int not null,
	permision int, /* 1. admin, 2. participe */
	foreign key (project_id) references project(id),
	foreign key (invited_id) references user(id)
);

create table comment(
	id int not null auto_increment primary key,
	comment text,
	task_id int not null,
	created_by int,
	created_at datetime,
	foreign key (task_id) references task(id),
	foreign key (created_by) references user(id)
);


create table notification(
	id int not null auto_increment primary key,
	kind int, /* 1. new comment */
	description text,
	task_id int,
	project_id int,
	user_receptor int,
	user_emisor int,
	created_at datetime,
	foreign key (task_id) references task(id),
	foreign key (project_id) references project(id),
	foreign key (user_receptor) references user(id),
	foreign key (user_emisor) references user(id)
);

