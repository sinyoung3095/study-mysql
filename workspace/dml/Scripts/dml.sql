create database dml;
use dml;

drop table tbl_zoo;
create table tbl_zoo(
   id bigint unsigned auto_increment primary key,
   zoo_name varchar(255) not null,
   zoo_address varchar(255) not null,
   zoo_address_detail varchar(255) not null,
   zoo_max_animal int check (zoo_max_animal > 0)
);

truncate table tbl_zoo;

/*insert into tbl_zoo
values(1, '애버랜드', '경기도 용인시', '12345', 10);
insert into tbl_zoo
values(2, '서울랜드', '경기도 과천', '55555', 5);*/

insert into tbl_zoo (zoo_name, zoo_address, zoo_address_detail, zoo_max_animal)
values('애버랜드', '경기도 용인시', '12345', 10);
insert into tbl_zoo (zoo_name, zoo_address, zoo_address_detail, zoo_max_animal)
values('서울랜드', '경기도 과천', '55555', 5);

/*select 
   id, zoo_name, zoo_address, 
   zoo_address_detail, zoo_max_animal 
from tbl_zoo
where id = 2;*/

select * from tbl_zoo;
create table tbl_animal(
   id bigint unsigned auto_increment primary key,
   animal_name varchar(255) not null,
   animal_type varchar(255) not null,
   animal_age int default 0,
   animal_height decimal(5, 2) check(animal_height > 0),
   animal_weight decimal(5, 2) check(animal_weight > 0),
   zoo_id bigint unsigned,
   constraint fk_animal_zoo foreign key(zoo_id)
   references tbl_zoo(id)
);

select * from tbl_zoo;
select * from tbl_animal;

insert into tbl_animal (animal_name, animal_type, animal_height, animal_weight)
values('호돌이', '호랑이', 205.42, 115.25);

update tbl_animal
set zoo_id = 1
where id = 2;

delete from tbl_animal
where id = 1;

/*insert 실습*/
/*첫번째 동물원에 두 마리의 동물*/
insert into tbl_animal (animal_name, animal_type, animal_height, animal_weight, zoo_id)
values('코붕이', '코끼리', 300.42, 999.25, 1);
insert into tbl_animal (animal_name, animal_type, animal_height, animal_weight, zoo_id)
values('장대', '기린', 800.42, 500.25, 1);

select * from tbl_animal
where zoo_id = 1;

/*두번째 동물원에 한 마리의 동물*/
insert into tbl_animal (animal_name, animal_type, animal_height, animal_weight)
values('꼬꼬', '독수리', 88.42, 44.25);

update tbl_animal
set zoo_id = 2
where id = 5;

select * from tbl_animal
where zoo_id = 2;

/*동물원 중에서 최대 수용 동물 수가 5보다 큰 동물원 조회*/
select * from tbl_zoo
where zoo_max_animal > 5;

/*동물원 중 1번 동물원의 동물 나이를 모두 1씩 증가*/
select * from tbl_animal;

update tbl_animal
set animal_age = animal_age + 1
where zoo_id = 1;

select * from tbl_animal
where zoo_id = 1;

/*동물 중에서 1번 동물원에 지내고 있는 동물 모두 삭제*/
select * from tbl_animal;

delete from tbl_animal
where zoo_id = 1;

select * from tbl_animal
where zoo_id = 1;

/****************************************************************************/

create table tbl_company(
   id bigint unsigned auto_increment primary key,
   company_name varchar(255),
   company_address varchar(255)
);

create table tbl_employee(
   id bigint unsigned auto_increment primary key,
   employee_name varchar(255),
   company_id bigint unsigned,
   constraint fk_employee_comapny foreign key(company_id)
   references tbl_company(id)
);

/*insert*/
/*회사 2군데 추가*/
select * from tbl_company;
select * from tbl_employee;

insert into tbl_company(company_name, company_address)
values('코리아', '역삼');
insert into tbl_company(company_name, company_address)
values('삼성', '논현');

/*각 회사에 직원 2명씩 추가*/
select * from tbl_company;
select * from tbl_employee;

insert into tbl_employee(employee_name, company_id)
values('홍길동', 1);
insert into tbl_employee(employee_name, company_id)
values('이순신', 1);
insert into tbl_employee(employee_name, company_id)
values('둘리', 2);
insert into tbl_employee(employee_name, company_id)
values('또치', 2);

/*select*/
/*'홍길동' 직원의 전체 정보 조회 */
select * from tbl_employee
where employee_name = '홍길동';

/*'홍길동' 또는 '이순신' 직원의 전체 정보 조회*/
select * from tbl_employee
where employee_name = '홍길동' or employee_name = '이순신';

/*'코리아'회사의 전체 정보 조회*/
select * from tbl_company
where company_name = '코리아';

/*update*/
/*'코리아' 회사에 다니는 직원의 이름을 모두 '둘리'로 수정*/
select id from tbl_company
where company_name = '코리아';

select * from tbl_employee
where company_id = 1;

update tbl_employee
set employee_name = '둘리'
where company_id = 1;

select * from tbl_employee
where company_id = 1;

/*delete*/
/*'홍길동' 직원 삭제 */
select * from tbl_employee
where employee_name = '둘리';

delete from tbl_employee
where employee_name = '둘리';

/****************************************************************************/
create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_id varchar(255),
   member_password varchar(255),
   member_age int,
   member_name varchar(255)
);

create table tbl_like(
   id bigint unsigned auto_increment primary key,
   like_receiver bigint unsigned,
   like_sender bigint unsigned,
   constraint fk_like_receiver_member foreign key(like_receiver)
   references tbl_member(id),
   constraint fk_like_sender_member foreign key(like_sender)
   references tbl_member(id)
);

/*insert*/
/*회원 3명 추가*/
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test1234', '1234', 10, '홍길동');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test5555', '1234', 20, '이순신');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test7777', '1234', 30, '장보고');

select * from tbl_member;
select * from tbl_like;
/*1번 -> 2번 좋아요*/
insert into tbl_like(like_receiver, like_sender)
values(2, 1);
/*1번 -> 3번 좋아요*/
insert into tbl_like(like_receiver, like_sender)
values(3, 1);
/*2번 -> 1번 좋아요*/
insert into tbl_like(like_receiver, like_sender)
values(1, 2);

select * from tbl_like;

/*select*/
/*1번을 좋아요 한 전체 회원 번호 조회*/
select * from tbl_like
where like_receiver = 1;

select * from tbl_member
where id = 2;

/*이름이 '홍길동'인 회원을 좋아요한 회원의 이름 조회*/
select * from tbl_member
where member_name = '홍길동';

select * from tbl_like
where like_receiver = 1;

select member_name from tbl_member
where id = 2;

/*update*/
/*2번 -> 1번 좋아요 취소, 2번 -> 3번 좋아요*/
update tbl_like 
set like_receiver = 3
where like_sender = 2 and like_receiver = 1;

select * from tbl_like
where like_sender = 2;

/*delete*/
/*1번 -> 2번 좋아요 취소*/
delete from tbl_like
where like_sender = 1 and like_receiver = 2;

select * from tbl_like
where like_sender = 1 and like_receiver = 2;

/****************************************************************************/
create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_id varchar(255),
   member_password varchar(255),
   member_age int,
   member_name varchar(255)
);
create table tbl_post(
   id bigint unsigned auto_increment primary key,
   post_title varchar(255) not null,
   post_content varchar(255) not null,
   created_date datetime default current_timestamp(),
   member_id bigint unsigned,
   constraint fk_post_member foreign key(member_id)
   references tbl_member(id)
);

insert into tbl_member(member_id, member_password, member_age, member_name) values('test1234', '1234', 10, '홍길동');

select * from tbl_member;
update tbl_member set member_id = 'test4321' where id =1 ;
delete from tbl_member where id >= 8;

insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test1234', '1234', 10, '홍길동');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test5555', '1234', 20, '이순신');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test7777', '1234', 30, '장보고');

select * from tbl_member;

select * from tbl_post;
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);

select p.post_title, p.post_content, m.member_name
from tbl_member m join tbl_post p
on m.id = p.member_id;

create table tbl_reply(
   id bigint unsigned auto_increment primary key,
   reply_content varchar(255),
   member_id bigint unsigned,
   post_id bigint unsigned,
   constraint fk_reply_member foreign key(member_id)
   references tbl_member(id),
   constraint fk_reply_post foreign key(post_id)
   references tbl_post(id)
);

INSERT INTO tbl_reply
(reply_content, member_id, post_id)
VALUES('테스트 댓글1', 3, 1);
INSERT INTO tbl_reply
(reply_content, member_id, post_id)
VALUES('테스트 댓글1', 2, 2);
INSERT INTO tbl_reply
(reply_content, member_id, post_id)
VALUES('테스트 댓글1', 2, 1);
INSERT INTO tbl_reply
(reply_content, member_id, post_id)
VALUES('테스트 댓글1', 1, 3);


/*댓글을 작성한 작성자 이름 조회*/
select r.reply_content, m.member_name 
from tbl_reply r join tbl_member m
on r.member_id = m.id;

/*댓글이 달린 게시글 제목 조회*/
select p.post_title, p.post_content, r.reply_content 
from tbl_reply r join tbl_post p
on r.post_id = p.id;

/*id가 test5555인 회원이 작성한 게시글 정보와 회원의 이름과 나이 조회*/
select p.id, p.post_title, p.post_content, p.created_date, m.member_name, m.member_age 
from tbl_member m join tbl_post p
on m.id = p.member_id and m.member_id = 'test5555';

/*댓글 작성자 중 나이가 10살인 회원 정보와 댓글 정보 조회*/
select * from tbl_reply r join tbl_member m
on r.member_id = m.id and m.member_age = 10;

/*댓글이 달린 게시글 정보와 댓글 정보 조회*/
select * from tbl_reply r join tbl_post p
on r.post_id = p.id;

/****************************************************************************/
create table tbl_user(
   id bigint unsigned auto_increment primary key,
   user_email varchar(255) unique not null,
   user_password varchar(255) not null,
   user_name varchar(255) not null,
   user_address varchar(255) not null,
   user_birth date
);

create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null,
   product_price int default 0,
   product_stock int default 0
);

create table tbl_order(
   id bigint unsigned auto_increment primary key,
   order_date datetime default current_timestamp(),
   user_id bigint unsigned,
   product_id bigint unsigned,
   constraint fk_order_user foreign key(user_id)
   references tbl_user(id),
   constraint fk_order_product foreign key(product_id)
   references tbl_product(id)
);

select * from tbl_user;

insert into tbl_user (user_email, user_password, user_name, user_address, user_birth)
values ('test@gmail.com', '1234', '테스트', '서울시 강남구', '2000-12-04');
insert into tbl_user (user_email, user_password, user_name, user_address, user_birth)
values ('test2@gmail.com', '1234', '테스트2', '서울시 강남구', str_to_date('2000년 01월 01일', '%Y년 %m월 %d일'));

select date_format(user_birth, '%Y년 %m월 %d일') 날짜 from tbl_user;

select * from tbl_product;

insert into tbl_product(product_name, product_price, product_stock)
values('핸드폰', 400000, 30), ('게임기v1', 150000, 5), ('게임기v2', 200000, 6), ('마우스', 55000, 52);

select concat('상품명:', product_name) from tbl_product;

select * from tbl_order;

/*%Y, %m, %d, %h, %i, %s*/
/*%Y-%m-%d %h:%i:%s*/
insert into tbl_order(user_id, product_id)
values(1, 3), (1, 2), (2, 3), (2, 1), (2, 3), (1, 1), (2, 1);

select date_format(order_date, '%Y년 %m월 %d일 %h시 %i분 %s초') "주문 날짜" from tbl_order;

select * from tbl_order;

/*구매자 이름, 구매자가 구매한 상품이름 조회*/

select u.user_name, p.product_name  
from tbl_order o join tbl_product p on o.product_id = p.id  
join tbl_user u on o.user_id =u.id   ;
/*like: 포함된 문자열 값을 찾고, 문자의 개수도 제한을 줄 수 있다.*/
/*%: 모든 것*/
/*_: 글자 수*/

/*
 * '%A'   :A로 끝나는 모든 값
 * 'A%'   :A로 시작하는 모든 값
 * '%A%':A가 포함된 모든 값
 * 'A_'   :A로 시작하면서 2글자인 값
 * '__A':A로 끝나면서 3글자인 값
 * */

select * from tbl_product
where product_name not like '핸%';

/*상품명에 v가 포함된 상품 검색*/
select * from tbl_product
where product_name like '%v%';

/*
 * ▶ index: buffer에 Page형태로 저장되어 전체 데이터를 검색하는 것 보다(full scan) 더 빠르다.
 * */
/*
 * ▶ search type
 * range: 인덱스 범위 스캔 (BETWEEN, LIKE, 'abc%')
 * index: 인덱스 전체 스캔 (상대적으로 느리다)
 * ALL: 테이블 전체 스캔 (느리다)
 * */
/*
 * ▶ 용도
 * index: =, like('abc%'), join, order by, group by
 * fulltext index: 자연어 검색, 부분 문자열 검색
 * */
/*
 * ▶ 최적 조건
 * index: =, >, <, between, like
 * fulltext index: match() against()
 * */
/*
 * ▶ 활용
 * index: where, join, group by, order by 모두 활용 가능
 * fulltext index: where, having, join 등에서 match()로 활용 가능
 * */
create table tbl_test(
   name varchar(255)
);

select * from tbl_test;

insert into tbl_test
values('김석'), ('한동석'), ('홍길동');

select * from tbl_test
where name = '한동석';

select * from tbl_test
where name like '한%';

select * from tbl_test
where name like '%한';

select * from tbl_test
where name like '%한%';
/***************************************************************/
drop table tbl_test;
create table tbl_test(
   name varchar(255),
   index(name)
);

insert into tbl_test
values('김석'), ('한동석'), ('홍길동');

select * from tbl_test;

select * from tbl_test
where name like '한%';

select * from tbl_test
where name like '%한';

select * from tbl_test
where name like '%한%';

drop table tbl_test;

/**/
create table tbl_test(
   name varchar(255),
   fulltext(name)
);

insert into tbl_test
values('김석'), ('한동석'), ('홍길동');

select * from tbl_test
where match(name) against('한동석');

show variables like 'ngram_token_size';
/**/
drop table tbl_test;
create table tbl_test(
   name varchar(255)
);

create fulltext index fk_idx_name on tbl_test(name) with parser ngram;

insert into tbl_test
values('김석'), ('한동석'), ('홍길동');

select * from tbl_test
where match(name) against('한동' in boolean mode);

show variables like 'ngram_token_size';

/***************************************************************/
/*
 * 집계 함수
 * 
 * 평균 avg()
 * 최대값 max()
 * 최소값 min()
 * 총합 sum()
 * 개수 count()
 * */

create table tbl_owner(
   id bigint unsigned auto_increment primary key,
   owner_name varchar(255) not null,
   owner_age int default 0,
   owner_phone varchar(255) not null,
   owner_address varchar(255) not null,
   owner_type enum('owner', 'center') default 'owner'
);

create table tbl_pet(
   id bigint unsigned auto_increment primary key,
   pet_ill_name varchar(255) not null,
   pet_name varchar(255),
   pet_age int not null,
   pet_weight decimal(5, 2) not null,
   owner_id bigint unsigned unsigned,
   constraint fk_pet_owner foreign key(owner_id)
   references tbl_owner(id)
);

insert into tbl_owner
(owner_name, owner_age, owner_phone, owner_address)
values
('한동석', 20, '01012341234', '경기도'),
('홍길동', 37, '01078784585', '서울'),
('이순신', 50, '01041812318', '대구');

select * from tbl_owner;


insert into tbl_pet
(pet_ill_name, pet_name, pet_age, pet_weight, owner_id)
values
('장염', '뽀삐', 4, 10.45, 1),
('감기', '달구', 12, 14.25, 2),
('탈골', '댕댕', 7, 8.46, 2),
('염좌', '쿠키', 11, 5.81, 3),
('충치', '바둑', 1, 3.47, 1);

select round(avg(pet_weight), 2) average_weight from tbl_pet;
select max(pet_weight) from tbl_pet;
select min(pet_weight) from tbl_pet;
select sum(pet_weight) from tbl_pet;
select count(*) from tbl_pet;

/*group by: ~별*/
insert into tbl_pet
(pet_ill_name, pet_name, pet_age, pet_weight, owner_id)
values
('장염', '방울', 4, 10.45, 1),
('장염', '초롱', 7, 8.46, 2),
('장염', '까미', 11, 5.81, 3);

select pet_ill_name, count(*) from tbl_pet
group by pet_ill_name;

select pet_ill_name, max(pet_weight) from tbl_pet
group by pet_ill_name;

/*
 * 실행 순서
 * from -> join -> on -> where -> group by -> select
 * */

/*주인별 동물병원에 등록한 반려동물 마리 수 조회*/
select owner_id, count(*) from tbl_pet
group by owner_id;

/*반려동물의 병명별 평균 나이와 그 주인들 중 가장 나이가 많은 주인 나이 조회*/
select  p.pet_ill_name 병명, avg(p.pet_age) 평균나이, max(o.owner_age) 주인_최대나이 
from tbl_owner o join tbl_pet p on o.id =p.owner_id 
group by p.pet_ill_name ;

/***************************************************************/
create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_name varchar(255) not null
);

create table tbl_kindergarten(
   id bigint unsigned auto_increment primary key,
   kindergarten_name varchar(255) not null,
   kindergarten_address varchar(255),
   member_id bigint unsigned,
   constraint fk_kindergarten_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_parent(
   id bigint unsigned auto_increment primary key,
   parent_name varchar(255) not null,
   parent_address varchar(255) not null,
   parent_phone varchar(255) not null,
   parent_gender varchar(255) default '선택 안함'
);

create table tbl_child(
   id bigint unsigned auto_increment primary key,
   child_age int not null,
   child_gender varchar(255) default '여아',
   child_name varchar(255) not null,
   parent_id bigint unsigned,
   constraint fk_child_parent foreign key(parent_id)
   references tbl_parent(id)
);



create table tbl_field_trip(
   id bigint unsigned auto_increment primary key,
   field_trip_title varchar(255) not null,
   field_trip_content varchar(255) not null,
   kindergarten_id bigint unsigned,
   created_date datetime default current_timestamp(),
   updated_date datetime default current_timestamp(),
   constraint fk_field_trip_kindergarten foreign key(kindergarten_id)
   references tbl_kindergarten(id)
);

create table tbl_file(
   id bigint unsigned auto_increment primary key,
   file_path varchar(255) not null,
   file_name varchar(255) not null,
   file_size int not null,
   field_trip_id bigint unsigned not null,
   constraint fk_file_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);

create table tbl_apply(
   id bigint unsigned auto_increment primary key,
   field_trip_id bigint unsigned not null,
   child_id bigint unsigned not null,
   constraint fk_apply_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id),
   constraint fk_apply_child foreign key(child_id)
   references tbl_child(id)
);


insert into tbl_parent
(parent_name, parent_address, parent_phone)
values
   ('한동석', '경기도', '01012341234'),
   ('홍길동', '서울', '01012341235'),
   ('이순신', '대구', '01012345654'),
   ('장보고', '광주', '01012845234');
   
  insert into tbl_child
(child_name, child_age, child_gender, parent_id)
values
   ('또치', 5, '남아', 2),
   ('둘리', 7, '여아', 2),
   ('도너', 4, '남아', 1),
   ('마이콜', 4, '남아', 3),
   ('짱구', 5, '여아', 4),
   ('짱아', 5, '여아', 4),
   ('신형만', 12, '남아', 2);
  
  insert into tbl_member
(member_name)
values('원장');

insert into tbl_kindergarten
(kindergarten_name, kindergarten_address, member_id)
values
   ('병설유치원', '경기도 고양시', 1),
   ('파랑새유치원', '서울시 강남구', 1),
   ('불교유치원', '경기도 고양시', 1),
   ('세화유치원', '경기도 고양시', 1),
   ('대명유치원', '경기도 고양시', 1);
  
  insert into tbl_field_trip
(field_trip_title, field_trip_content, kindergarten_id)
values
   ('어서와 매미농장', '매미 잡자 어서와', 1),
   ('아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 3),
   ('고구마 심기', '고구마가 왕 커요', 2),
   ('숭어 얼음 낚시', '숭어 잡자 추워도 참아', 4),
   ('커피 체험 공장', '커비 빈 객체화', 4),
   ('치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 4),
   ('동물 타보기', '이리야!', 2);
  
  
  insert into tbl_apply
(field_trip_id, child_id)
values
   (1, 1),
   (2, 2),
   (3, 6),
   (4, 7),
   (1, 5),
   (2, 3),
   (5, 7),
   (6, 6),
   (4, 1),
   (4, 5),
   (7, 3);
  
 /*가장 인기있는(지원을 많이 한) 체험학습의 지원자 수 조회*/
/*order by: 정렬*/
/*
 * 실행 순서
 * from -> join -> on -> where -> group by -> select -> order by
 * */
/*
 * limit A, B
 * A(0)부터 B개
 * 
 * limit A
 * 처음부터 A개
 * */
select field_trip_id, count(child_id) ct from tbl_apply
group by field_trip_id
order by ct desc
limit 1;

/*신청한 체험학습별 아이들의 평균 나이 조회*/
select a.field_trip_id, avg(c.child_age)
from tbl_child c join tbl_apply a
on c.id = a.child_id
group by a.field_trip_id;

/*각 유치원들의 체험학습 진행 건수*/
select kindergarten_id, count(id) 
from tbl_field_trip
group by kindergarten_id;

/*각 유치원들의 체험학습 지원 건수*/
select kindergarten_id, count(a.child_id)
from tbl_field_trip ft join tbl_apply a
on ft.id = a.field_trip_id
group by kindergarten_id;

/*
 * 실행 순서
 * from -> join -> on -> where -> group by -> having -> select -> order by
 * */
/*각 체험학습 지원 건수*/
select field_trip_id, count(child_id) ct 
from tbl_apply
group by field_trip_id
having count(child_id) >= 2;
/*
 * 서브 쿼리
 * 
 * 메인 쿼리 안에 또 다른 쿼리를 작성하는 문법
 * 
 * from: 인라인 뷰
 * where: 서브 쿼리
 * select: 스칼라 서브 쿼리
 * 
 * */

/*회원 정보에서 이름이 원장인 사람의 전체 정보 조회*/
select * from tbl_member
where member_name = '원장';

select * from tbl_member
where id = 1;

/*1. from절*/
select m.id, m.member_name
from
(
   select * from tbl_member
   where member_name = '원장'   
) m;

/*2. where절*/

select * from tbl_member
where id = (
   select id  from tbl_member
   where member_name = '원장'
);

/*3. select절*/
select 
(
   select id from tbl_member
   where member_name = '원장'
)
from tbl_member;
/*****************************************************************/
create table tbl_like(
   id bigint unsigned auto_increment primary key,
   like_receiver bigint unsigned,
   like_sender bigint unsigned,
   constraint fk_like_receiver_member foreign key(like_receiver)
   references tbl_member(id),
   constraint fk_like_sender_member foreign key(like_sender)
   references tbl_member(id)
);

insert into tbl_member
(member_name)
values('홍길동'), ('이순신');

select * from tbl_member;

insert into tbl_like
(like_receiver, like_sender)
values 
   (1, 2),
   (3, 2),
   (2, 1),
   (1, 3),
   (1, 2),
   (1, 3),
   (2, 1),
   (3, 1);

/*좋아요가 가장 많은 회원 정보 조회*/
select * from tbl_member m1
join
(
   select like_receiver, count(*) ct from tbl_like
   group by like_receiver
   order by ct desc
   limit 1
) m2
on m1.id = m2.like_receiver;

select like_receiver, m.member_name, count(*) ct 
from tbl_member m join tbl_like l
on m.id = l.like_receiver
group by like_receiver
order by ct desc
limit 1;

/*각 성별의 평균 나이와 전체 평균 나이 조회*/
select child_gender, avg(child_age),
(
   select avg(child_age) from tbl_child
)
from tbl_child
group by child_gender;
/****************************************************************************/
create table tbl_user(
   id bigint unsigned auto_increment primary key,
   user_email varchar(255) unique not null,
   user_password varchar(255) not null,
   user_name varchar(255) not null,
   user_address varchar(255) not null,
   user_age int
);

create table tbl_product(
   id bigint unsigned auto_increment primary key,
   product_name varchar(255) not null,
   product_price int default 0,
   product_stock int default 0
);

create table tbl_order(
   id bigint unsigned auto_increment primary key,
   order_date datetime default current_timestamp(),
   user_id bigint unsigned,
   product_id bigint unsigned,
   constraint fk_order_user foreign key(user_id)
   references tbl_user(id),
   constraint fk_order_product foreign key(product_id)
   references tbl_product(id)
);
insert into tbl_user (user_email, user_password, user_name, user_address, user_age)
values 
   ('test@gmail.com', '1234', '테스트', '서울시 강남구', 30),
   ('test2@gmail.com', '1234', '테스트2', '서울시 강남구', 20),
   ('test3@gmail.com', '1234', '테스트2', '서울시 강남구', 20),
   ('test4@gmail.com', '1234', '테스트2', '서울시 강남구', 40),
   ('test5@gmail.com', '1234', '테스트2', '서울시 강남구', 30),
   ('test6@gmail.com', '1234', '테스트2', '서울시 강남구', 30),
   ('test7@gmail.com', '1234', '테스트2', '서울시 강남구', 50);

insert into tbl_product(product_name, product_price, product_stock)
values
   ('핸드폰', 400000, 30), ('게임기v1', 150000, 5), ('게임기v2', 200000, 6), ('마우스', 55000, 52),
   ('키보드', 400000, 30), ('게임기v3', 150000, 5), ('게임기v4', 200000, 6), ('모니터', 55000, 52);

insert into tbl_order(user_id, product_id)
values
   (1, 3), (1, 2), (2, 3), (2, 1), (2, 3), (1, 1), (2, 1),
   (5, 4), (6, 4), (6, 5), (7, 8), (4, 8), (4, 7), (7, 1);

select * from tbl_order;

/*20대 중에서 구매 가격이 100000원을 넘는 주문번호, 상품가격, 연령대 조회*/

select u.user_age from tbl_order o join tbl_user u 
on o.user_id = u.id join tbl_product p on o.product_id = p.id
group by u.user_age;

/********************************************************************/
/*외부 조인*/
create table tbl_member(
   id bigint unsigned auto_increment primary key,
   member_id varchar(255),
   member_password varchar(255),
   member_age int,
   member_name varchar(255)
);

create table tbl_post(
   id bigint unsigned auto_increment primary key,
   post_title varchar(255) not null,
   post_content varchar(255) not null,
   created_date datetime default current_timestamp(),
   member_id bigint unsigned,
   constraint fk_post_member foreign key(member_id)
   references tbl_member(id)
);

insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test1234', '1234', 10, '홍길동');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test5555', '1234', 20, '이순신');
insert into tbl_member
(member_id, member_password, member_age, member_name)
values('test7777', '1234', 30, '장보고');

update tbl_member 
set member_name = '홍길동'
where id = 1;

select *from tbl_member tm ;

select * from tbl_post;
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 2);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);
insert into tbl_post(post_title, post_content, member_id)
values('테스트 제목1', '테스트 내용1', 1);

select m.member_name, count(p.id) 
from tbl_member m 
left outer join tbl_post p
on m.id = p.member_id
group by member_name;

/*회원 목록에서 작성한 게시글 제목도 조회*/
select m.*, m.member_name, p.post_title  from tbl_member m left outer join tbl_post p 
on m.id = p.member_id and p.id >0;


