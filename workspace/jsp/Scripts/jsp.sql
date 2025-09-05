use jsp;

CREATE TABLE tbl_member (
  id bigint NOT null PRIMARY KEY,
  member_id varchar(255) DEFAULT NULL,
  member_password varchar(255) DEFAULT NULL,
  member_age int DEFAULT NULL
) 