use test;

create table tbl_user(
	id bigint unsigned auto_increment primary key,
	user_name varchar(255) not null,
	user_kind enum('인간','드워프','엘프') not null default '인간',
	user_height decimal(5,2) not null	
);

create table tbl_user_item(
	id bigint unsigned auto_increment primary key,
	item_name varchar(255) not null,
	item_price bigint default 0,
	item_count bigint default 0,
	user_id bigint unsigned not null,
	constraint tbl_user_item_user foreign key (user_id)
	references tbl_user(id)
);

create table tbl_item_weapon(
	id bigint unsigned auto_increment primary key,
	attack bigint default 0,
	effect varchar(255),
	item_id bigint unsigned,
	constraint weapon_item foreign key (item_id)
	references tbl_user_item(id)
	
);

insert into tbl_item_weapon(attack,effect, item_id) values(2530,'감전',1),(3200, '화상',2),(520, '저주',3),(2750, '블라인드', 5);

insert into tbl_user(user_name,user_kind,user_height) values('data','인간',185.15);
insert into tbl_user(user_name,user_kind,user_height) values('test','드워프',145.25);
insert into tbl_user(user_name,user_kind,user_height) values('task','엘프',191.11);
insert into tbl_user(user_name,user_kind,user_height) values('tokky','인간',175.11);

delete from tbl_user where id = 6;
select * from tbl_user ;

insert into tbl_user_item(item_name,item_price,item_count, user_id)
values('검',30000,1,1);
insert into tbl_user_item(item_name,item_price,item_count, user_id)
values('도끼',35000,1,2);
insert into tbl_user_item(item_name,item_price,item_count, user_id)
values('화살',3000,50,3);
insert into tbl_user_item(item_name,item_price,item_count, user_id)
values('스태프',50000,1,5);

select * from tbl_user_item;

select *from tbl_user u join tbl_user_item i on u.id = i.user_id
;

update tbl_user_item
set item_price = 50000
where user_id = 1;

select * from tbl_user;

delete from tbl_user where id =4 ;

update tbl_user 
set user_name = 'ttokky'
where id = 4;

insert into tbl_user_item(item_name, item_price, item_count,user_id)
values ('롱보우', 45000, 1, 3);

update tbl_user_item
set item_count = item_count -1
where user_id =3 and id =3;

select * from tbl_user u left outer join tbl_user_item i on u.id =i.user_id ;

select u.user_kind, count(i.id)  from tbl_user u left outer join tbl_user_item i on u.id =i.user_id 
group by u.user_kind ;





