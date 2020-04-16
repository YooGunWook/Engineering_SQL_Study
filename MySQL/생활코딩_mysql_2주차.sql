# 데이터베이스를 새로 만들어주는 기능
create database tutorials;

# 데이터베이스를 삭제하는 기능
drop database tutorials;

# 데이터베이스 찾는 기능
show databases;
show schemas;

# 특정 데이터베이스만 사용하기 위한 쿼리문
use tutorials;

# table -> x측: row, record
# -> y축: columns

# 각 col 별로 데이터 타입을 강제할 수 있다.
# 최대한 목적에 맞게 데이터 타입을 정해줘야 한다.
# 안그러면 컴퓨터가 느려지거나 성능이 떨어지게 된다.

CREATE TABLE TOPIC(
    # 값이 없는 것을 허용하지 않고, 자동으로 숫자가 지정된다.
    ID INT(11) NOT NULL AUTO_INCREMENT,
    # varchar은 string의 length가 가변적일 때 사용하면 좋다.
    TITLE VARCHAR(100) NOT NULL,
    DESCRIPTION TEXT NULL,
    CREATED DATETIME NOT NULL,
    AUTHOR VARCHAR(30) NULL,
    PROFILE VARCHAR(100) NULL,
    # main key를 지정해주는 것.
    # 성능에도 도움이 되고, 중복 문제도 해결해준다.
    PRIMARY KEY(ID)
);

# CRUD 데이터베이스에서는 반드시 가져야되는 4가지
# Create
# Read
# Update
# Delete

# insert 기능
use tutorials;

show tables;

# 테이블에 값을 넣는 방법
insert into TOPIC(TITLE,DESCRIPTION,CREATED, AUTHOR,PROFILE) values('MySQL', 'MySQL is ...', NOW(),'egoing','developer');
# NOW() 함수를 쓰면 현재 시간이 자동으로 입력된다.

# 테이블을 선택하고 조회하는 법
# *은 모든 데이터 col을 볼 수 있다.
SELECT * FROM TOPIC;

insert into TOPIC(TITLE,DESCRIPTION,CREATED, AUTHOR,PROFILE) values('ORACLE', 'ORACLE is ...', NOW(),'egoing','developer');

SELECT * FROM TOPIC;

insert into TOPIC(TITLE,DESCRIPTION,CREATED, AUTHOR,PROFILE) values('SQL Sever', 'SQL Sever is ...', NOW(),'taeho','data administrator');
insert into TOPIC(TITLE,DESCRIPTION,CREATED, AUTHOR,PROFILE) values('PostregeSQL', 'PostregeSQL is ...', NOW(),'duru','developer');
insert into TOPIC(TITLE,DESCRIPTION,CREATED, AUTHOR,PROFILE) values('MongoDB', 'MongoDB is ...', NOW(),'egoing','developer');

SELECT * FROM TOPIC;

# select와 create, insert는 꽤 많이 사용하게 된다.
# 데이터를 읽는 것이 가장 복잡할 수 있다.

# 특정 col만 보고 싶다면 *에 그 col 이름을 쓰면 된다.
select id, title, created, author from TOPIC;

# where 문을 통해서 조건을 지정해서 search할 수 있다.
select id, title, created, author from TOPIC
where author = 'egoing';

# 정렬 기능도 사용할 수 있다.
select id, title, created, author from TOPIC
where author = 'egoing'
order by id desc;

# 상위 몇개만 지정해서 볼 수 있다.(제한을 거는 것)
select id, title, created, author from TOPIC
where author = 'egoing'
order by id desc
limit 2;

# 수정은 update 문을 사용해서 하면 된다.
DESC topic;

select * from topic;

update topic set DESCRIPTION='Oracle is ...', title ='Oracle'
where id = 2;
# update는 자주 사용하지 않는다.
# where문을 꼭 사용해서 update 하자.

# row를 삭제할 때는 delete문 쓰자. 이것도 where문 꼭 사용
delete from TOPIC where id = 5;

select * from TOPIC;
