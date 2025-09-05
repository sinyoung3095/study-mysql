use ddl;

/*
 * 회원 테이블
 *  
 * 회원 번호
 * 회원 아이디
 * 회원 비밀번호
 * 회원 나이
 * */
create table tbl_member(
   id bigint primary key,
   member_id varchar(255),
   member_password varchar(255),
   member_age int
);

/*
 * 동물원 테이블
 * 
 * 고유 번호
 * 동물원 이름
 * 동물원 주소
 * 동물원 상세 주소
 * 동물 최대 수용치
 * */
create table tbl_zoo(
   id bigint primary key,
   zoo_name varchar(255) not null,
   zoo_address varchar(255) not null,
   zoo_address_detail varchar(255) not null,
   zoo_max_animal int check (zoo_max_animal > 0)
);

/*
 * 동물 테이블
 * 
 * 고유 번호
 * 동물 이름
 * 동물 종류
 * 동물 나이
 * 동물 키
 * 동물 몸무게
 * 동물원 번호
 * 
 * */
create table tbl_animal(
   id bigint primary key,
   animal_name varchar(255) not null,
   animal_type varchar(255) not null,
   animal_age int default 0,
   animal_height decimal(3, 2) check(animal_height > 0),
   animal_weight decimal(3, 2) check(animal_weight > 0),
   zoo_id bigint,
   constraint fk_animal_zoo foreign key(zoo_id)
   references tbl_zoo(id)
);
/*
 * 회사
 * 번호
 * 회사 이름
 * 회사 주소
 * */
create table tbl_company(
   id bigint unsigned primary key,
   company_name varchar(255),
   company_address varchar(255)
);

/*
 * 직원
 * 번호
 * 이름
 * */
create table tbl_employee(
   id bigint unsigned primary key,
   employee_name varchar(255),
   company_id bigint unsigned,
   constraint fk_employee_comapny foreign key(company_id)
   references tbl_company(id)
);

/*
 *    회원         주문         상품
   -------------------------------
   번호P         번호P         번호P
   -------------------------------
   이메일U NN   날짜 D(CT)   이름 NN
   비밀번호 NN   회원번호    F   가격 D(0)
   이름 NN      상품번호   F   재고 D(0)
   주소 NN
   생일   
   
 * */

create table tbl_user(
   id bigint unsigned primary key,
   user_email varchar(255) unique not null,
   user_password varchar(255) not null,
   user_name varchar(255) not null,
   user_address varchar(255) not null,
   user_birth date
);

create table tbl_product(
   id bigint unsigned primary key,
   product_name varchar(255) not null,
   product_price int default 0,
   product_stock int default 0
);

create table tbl_order(
   id bigint unsigned primary key,
   order_date datetime default current_timestamp(),
   user_id bigint unsigned,
   product_id bigint unsigned,
   constraint fk_order_user foreign key(user_id)
   references tbl_user(id),
   constraint fk_order_product foreign key(product_id)
   references tbl_product(id)
);

/*
 * 1. 요구사항 분석
 *       꽃 테이블과 화분 테이블 2개가 필요하고,
 *     꽃을 구매할 때 화분도 같이 구매합니다.
 *     꽃은 이름과 색상, 가격이 있고
 *     화분은 제품번호, 색상, 모양이 있습니다.
 *       화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.
 */

create table tbl_flower(
   id bigint unsigned primary key,
   flower_name varchar(255),
   flower_color varchar(255),
   flower_price varchar(255)
);

alter table tbl_flower drop constraint id;

create table tbl_pot(
   id bigint unsigned primary key,
   pot_color varchar(255),
   pot_shape varchar(255),
   flower_id bigint unsigned,
   constraint fk_pot_flower foreign key(flower_id)
   references tbl_flower(id)
);

alter table tbl_pot drop constraint fk_pot_flower;
alter table tbl_pot drop flower_id;

create table tbl_flower_pot(
   id bigint unsigned primary key,
   flower_id bigint unsigned,
   pot_id bigint unsigned,
   constraint fk_flower foreign key(flower_id)
   references tbl_flower(id),
   constraint fk_pot foreign key(pot_id)
   references tbl_pot(id)
);

drop table tbl_flower_pot;
drop table tbl_flower;
drop table tbl_pot;

/*꽃은 이름과 색상, 가격이 있고*/
create table tbl_flower(
   flower_name varchar(255),
   flower_color varchar(255),
   flower_price varchar(255),
   constraint pk_flower primary key(flower_name, flower_color)
);

create table tbl_pot(
   id bigint unsigned primary key,
   pot_color varchar(255),
   pot_shape varchar(255)
);

create table tbl_flower_pot(
   id bigint unsigned primary key,
   flower_name varchar(255),
   flower_color varchar(255),
   pot_id bigint unsigned,
   constraint fk_flower foreign key(flower_name, flower_color)
   references tbl_flower(flower_name, flower_color),
   constraint fk_pot foreign key(pot_id)
   references tbl_pot(id)
);

/*
 * 1. 요구사항 분석
 *    안녕하세요, 동물병원을 곧 개원하는 원장입니다.
 *    동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
 *    보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
 *    보호자는 이름, 나이, 전화번호, 주소 정보를 알려줘야 하고
 *    동물은 병명, 이름, 나이, 몸무게 정보가 필요합니다.
 * 
 */
/*create table tbl_owner(
   id bigint unsigned primary key,
   owner_name varchar(255) not null,
   owner_age int default 0,
   owner_phone varchar(255) not null,
   owner_address varchar(255) not null
);

create table tbl_pet(
   id bigint unsigned primary key,
   pet_ill_name varchar(255) not null,
   pet_name varchar(255),
   pet_age int not null,
   pet_weight decimal(3, 2) not null,
   owner_id bigint unsigned,
   constraint fk_pet_owner foreign key(owner_id)
   references tbl_owner(id)
);*/

/*create table tbl_owner(
   id bigint unsigned primary key,
   owner_name varchar(255) not null,
   owner_age int default 0,
   owner_phone varchar(255) not null,
   owner_address varchar(255) not null,
   owner_type enum('owner', 'center') default 'owner'
);

create table tbl_pet(
   id bigint unsigned primary key,
   pet_ill_name varchar(255) not null,
   pet_name varchar(255),
   pet_age int not null,
   pet_weight decimal(3, 2) not null,
   owner_id bigint unsigned,
   constraint fk_pet_owner foreign key(owner_id)
   references tbl_owner(id)
);*/

create table tbl_guardian(
   id bigint unsigned primary key,
   guardian_name varchar(255) not null,
   guardian_phone varchar(255) not null,
   guardian_address varchar(255) not null
);

create table tbl_owner(
   id bigint unsigned primary key,
   owner_age int default 0,
   constraint fk_owner_guardian foreign key(id)
   references tbl_guardian(id)
);

create table tbl_center(
   id bigint unsigned primary key,
   builder_name varchar(255) not null,
   constraint fk_owner_center foreign key(id)
   references tbl_guardian(id)
);

alter table tbl_center add builder_name varchar(255) not null;

create table tbl_pet(
   id bigint unsigned primary key,
   pet_ill_name varchar(255) not null,
   pet_name varchar(255),
   pet_age int not null,
   pet_weight decimal(3, 2) not null,
   guardian_id bigint unsigned not null,
   constraint fk_pet_guardian foreign key(guardian_id)
   references tbl_guardian(id)
);

/*
1. 요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(TBL_MEMBER)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.
*/
create table tbl_member(
   id bigint unsigned primary key,
   member_id varchar(255),
   member_password varchar(255),
   member_age int
);

create table tbl_post(
   id bigint unsigned primary key,
   post_title varchar(255) not null,
   post_content varchar(255) not null,
   created_date datetime default current_timestamp(),
   member_id bigint unsigned,
   constraint fk_post_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_reply(
   id bigint unsigned primary key,
   reply_content varchar(255),
   member_id bigint unsigned,
   post_id bigint unsigned,
   constraint fk_reply_member foreign key(member_id)
   references tbl_member(id),
   constraint fk_reply_post foreign key(post_id)
   references tbl_post(id)
);

/*
   1. 요구 사항
       마이페이지에서 회원 프로필을 구현하고 싶습니다.
       회원당 프로필을 여러 개 설정할 수 있다.
       
       *파일 테이블
       *경로
       *이름
       *크기
*/
create table tbl_profile(
	id bigint unsigned primary key,
	file_id bigint unsigned,
	member_id bigint unsigned,
	constraint fk_profile_file foreign key(file_id)
   references tbl_file(id),
   constraint fk_profile_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_file(
   id bigint unsigned primary key,
   file_name varchar(255),
   file_path varchar(255),
   file_size int default 0,
   member_id bigint unsigned,
   file_check enum('selected', 'none') default 'none'
   constraint fk_file_member foreign key(member_id)
   references tbl_member(id)
);

/*
1. 요구 사항
    회원들끼리 좋아요를 누를 수 있습니다.
    좋아요를 *받은* 사람과 *준* 사람 둘 다 저장해야 한다.
*/

create table tbl_like(
   id bigint unsigned primary key,
   like_receiver bigint unsigned,
   like_sender bigint unsigned,
   constraint fk_like_receiver_member foreign key(like_receiver)
   references tbl_member(id),
   constraint fk_like_sender_member foreign key(like_sender)
   references tbl_member(id)
);
/*
    1. 요구사항 분석
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.
*/

create table tbl_registration(
	id bigint unsigned primary key,
	car_id bigint unsigned,
	car_owner_id bigint unsigned,
	constraint fk_registration_car foreign key(car_id)
   references tbl_car(id),
   constraint fk_registration_car_owner foreign key(car_owner_id)
   references tbl_car_owner(id)
);

create table tbl_car(
	id bigint unsigned primary key,
	brand varchar(255) not null,
	model varchar(255) not null,
	price bigint unsigned default 0,
	created_date datetime default current_timestamp()
);

create table tbl_car_owner(
	id bigint unsigned primary key,
	name varchar(255),
	phone bigint unsigned,
	address varchar(255)
);

/*
1. 요구사항
    대카테고리, 소카테고리가 필요해요.
*/
create table tbl_category_A(
   id bigint unsigned primary key,
   category_A_name varchar(255) not null
);

create table tbl_category_B(
   id bigint unsigned primary key,
   category_B_name varchar(255) not null,
   category_A_id bigint unsigned,
   constraint fk_category_B_category_A foreign key(category_A_id)
   references tbl_category_A(id)
);

/*
1. 요구사항
   회의실 예약 서비스를 제작하고 싶습니다.
   회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
   회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
   
*/
create table tbl_office(
id bigint unsigned primary key,
name varchar(255)
);
create table tbl_reservation(
id bigint unsigned primary key,
part_time_id bigint unsigned,
client_id bigint unsigned,
constraint reservation_part_time foreign key(part_time_id)
references tbl_part_time(id),
constraint reservation_client foreign key(client_id)
references tbl_client(id)
);
create table tbl_conference_room(
id bigint unsigned primary key,
office_id bigint unsigned,
constraint conference_room_office foreign key(office_id)
references tbl_office(id)
);
create table tbl_part_time(
id bigint unsigned primary key,
conference_room_id bigint unsigned,
constraint part_time_conference_room foreign key(conference_room_id)
references tbl_conference_room(id)
);
create table tbl_client(
id bigint unsigned primary key
);

/*
1. 요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
*/

create table tbl_member(
   id bigint unsigned primary key,
   member_name varchar(255) not null
);

create table tbl_kindergarten(
   id bigint unsigned primary key,
   kindergarten_name varchar(255) not null,
   kindergarten_address varchar(255),
   member_id bigint unsigned,
   constraint fk_kindergarten_member foreign key(member_id)
   references tbl_member(id)
);

create table tbl_parent(
   id bigint unsigned primary key,
   parent_name varchar(255) not null,
   parent_address varchar(255) not null,
   parent_phone varchar(255) not null,
   parent_gender varchar(255) default '선택 안함'
);

create table tbl_child(
   id bigint unsigned primary key,
   child_age int not null,
   child_gender varchar(255) default '여아',
   parent_id bigint unsigned,
   constraint fk_child_parent foreign key(parent_id)
   references tbl_parent(id)
);

create table tbl_field_trip(
   id bigint unsigned primary key,
   field_trip_title varchar(255) not null,
   field_trip_content varchar(255) not null,
   kindergarten_id bigint unsigned,
   created_date datetime default current_timestamp(),
   updated_date datetime default current_timestamp(),
   constraint fk_field_trip_kindergarten foreign key(kindergarten_id)
   references tbl_kindergarten(id)
);

create table tbl_file(
   id bigint unsigned primary key,
   file_path varchar(255) not null,
   file_name varchar(255) not null,
   file_size int not null,
   field_trip_id bigint unsigned not null,
   constraint fk_file_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id)
);

create table tbl_apply(
   id bigint unsigned primary key,
   field_trip_id bigint unsigned not null,
   child_id bigint unsigned not null,
   constraint fk_apply_field_trip foreign key(field_trip_id)
   references tbl_field_trip(id),
   constraint fk_apply_child foreign key(child_id)
   references tbl_child(id)
);



/*
1. 요구사항
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.
*/

create table tbl_category_A(
   id bigint unsigned primary key,
   category_A_name varchar(255) not null
);

create table tbl_category_B(
   id bigint unsigned primary key,
   category_B_name varchar(255) not null,
   category_A_id bigint unsigned,
   constraint fk_category_B_category_A foreign key(category_A_id)
   references tbl_category_A(id)
);

create table tbl_category_C(
   id bigint unsigned primary key,
   category_C_name varchar(255) not null,
   category_B_id bigint unsigned,
   constraint fk_category_C_category_B foreign key(category_B_id)
   references tbl_category_B(id)
);

create table tbl_ad(
   id bigint unsigned primary key,
   ad_title varchar(255) not null,
   ad_contents varchar(255) not null,
   category_C_id bigint unsigned not null,
   constraint fk_ad_category_C foreign key(category_C_id)
   references tbl_category_C(id)
);

create table tbl_company(
   id bigint unsigned primary key,
   comapny_name varchar(255) not null,
   comapny_address varchar(255) not null,
   comapny_tel varchar(255) not null,
   comapny_type enum('a', 'b', 'c', 'd') default 'a'
);

create table tbl_apply(
   id bigint unsigned primary key,
   company_id bigint unsigned not null,
   ad_id bigint unsigned not null,
   constraint fk_apply_company foreign key(company_id)
   references tbl_company(id),
   constraint fk_apply_ad foreign key(ad_id)
   references tbl_ad(id)
);

/*
1. 요구사항
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.
*/
create table tbl_soft_drink(
   id bigint unsigned primary key,
   soft_drink_name varchar(255) not null
);

create table tbl_product(
   id bigint unsigned primary key,
   product_name varchar(255) not null,
   product_stockt int default 0
);

create table tbl_lottery(
   id bigint unsigned primary key,
   lottery_number varchar(255) not null,
   product_id bigint unsigned,
   constraint fk_lottery_product foreign key(product_id)
   references tbl_product(id)
);

create table tbl_circulation(
   id bigint unsigned primary key,
   soft_drink_id bigint unsigned,
   lottery_id bigint unsigned,
   constraint fk_circulation_soft_drink foreign key(soft_drink_id)
   references tbl_soft_drink(id),
   constraint fk_circulation_lottery foreign key(lottery_id)
   references tbl_lottery(id)
);

create table tbl_member(
   id bigint unsigned primary key,
   member_name varchar(255),
   member_address varchar(255)
);

create table tbl_delivery(
   id bigint unsigned primary key,
   delivery_status enum('상품 준비', '배송중', '배송 완료') default '상품 준비',
   member_id bigint unsigned,
   product_id bigint unsigned,
   constraint fk_delivery_member foreign key(member_id)
   references tbl_member(id),
   constraint fk_delivery_product foreign key(product_id)
   references tbl_product(id)
);


/*
1. 요구사항
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
   상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.
*/
create table tbl_company(
   id bigint unsigned primary key,
   company_name varchar(255) not null,
   company_address varchar(255) not null,
   company_tel varchar(255) not null
);

create table tbl_client(
   id bigint unsigned primary key,
   client_name varchar(255) not null,
   client_address varchar(255) not null,
   client_tel varchar(255) not null
);

create table tbl_card(
   id bigint unsigned primary key,
   card_number varchar(255) not null,
   card_company varchar(255) not null,
   client_id bigint unsigned not null,
   constraint fk_card_client foreign key(client_id)
   references tbl_client(id)
);

create table tbl_product(
   id bigint unsigned primary key,
   product_name varchar(255) not null,
   product_price int default 0,
   product_stock int default 0,
   company_id bigint unsigned not null,
   constraint fk_product_comapny foreign key(company_id)
   references tbl_company(id)
);

create table tbl_pay(
   id bigint unsigned primary key,
   card_id bigint unsigned not null,
   product_id bigint unsigned not null,
   constraint fk_pay_card foreign key(card_id)
   references tbl_card(id),
   constraint fk_pay_product foreign key(product_id)
   references tbl_product(id)
);