# 관계형 데이터베이스의 필요성
# 데이터가 중복해서 나타나는 경우가 있다.
# 중복 데이터는 문제를 발생시킨다.
# 경제적 기술적으로 손해. 수정할 때 어려움을 겪게 된다.
# 관계형 데이터베이스를 쓰게 되면 유지보수 하기 쉬워진다.
# 여러 테이블을 만들어서 primary key, foreign key를 통해 중복을 제거할 수 있다.
# 저장은 분산으로 하고 합쳐서 확인활 수 있기 때문에 굉장히 효율적이다. (join문을 통해 합칠 수 있다)

show tables;
rename table topic to topic_backup;


--
-- Table structure for table `author`
--


CREATE TABLE author (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `profile` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

select * from author;

--
-- Dumping data for table `author`
--

INSERT INTO author VALUES (1,'egoing','developer');
INSERT INTO author VALUES (2,'duru','database administrator');
INSERT INTO author VALUES (3,'taeho','data scientist, developer');

--
-- Table structure for table `topic`
--

CREATE TABLE topic (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `description` text,
  `created` datetime NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

select * from topic;

--
-- Dumping data for table `topic`
--

INSERT INTO topic VALUES (1,'MySQL','MySQL is...','2018-01-01 12:10:11',1);
INSERT INTO topic VALUES (2,'Oracle','Oracle is ...','2018-01-03 13:01:10',1);
INSERT INTO topic VALUES (3,'SQL Server','SQL Server is ...','2018-01-20 11:01:10',2);
INSERT INTO topic VALUES (4,'PostgreSQL','PostgreSQL is ...','2018-01-23 01:03:03',3);
INSERT INTO topic VALUES (5,'MongoDB','MongoDB is ...','2018-01-30 12:31:03',1);

-- 여기까지 데이터 만들기

# join문 사용하기
# 왼쪽 데이터 기준으로 join하기

SELECT * FROM TOPIC LEFT JOIN AUTHOR ON TOPIC.author_id = author.id;

# id가 두개 생김. 따라서 이것을 구분하기 위해서는 id에 어떤 데이터의 id인지 설정해줘야함.
SELECT topic.id,
       title,
       description,
       created,
       name,
       profile
FROM TOPIC
    LEFT JOIN AUTHOR ON TOPIC.author_id = author.id;

# as를 쓰면 그 컬럼의 아이디를 바꿀 수 있다.
SELECT topic.id as topic_id,
       title,
       description,
       created,
       name,
       profile
FROM TOPIC
    LEFT JOIN AUTHOR ON TOPIC.author_id = author.id;

# join을 통해 데이터들 간에 관계를 맺을 수 있다.
# join을 통해 새로운 데이터를 만들 수 있다.

# 인터넷과 데이터베이스의 관계

# 인터넷이 동작하기 위해서는 2대의 컴퓨터가 필요함.
# 인터넷은 각자 흩어져 있는 컴터들이 인터넷으로 연결되면서 사회를 만들어준다.
# 요청과 응답이 존재한다. -> 웹
# 요청하는 쪽은 client, 응답하는 쪽은 server라고 부른다.
# mysql 설치 시 데이터베이스 client, database server를 만들어준다.
# 데이터베이스 client는 여러가지가 있다. 원하는 client를 사용하면 된다.
# 데이터베이스 서버에 데이터를 저장하고, client가 서버 중심으로 데이터를 넣고 빼고가 가능해진다.

# mysql monitor는 언제 어디서든 사용할 수 있다. (명령어 기반)
# gui 기반은 편리하게 사용할 수 있다.

# 데이터가 많아지면 데이터를 꺼내기 어려워진다.
# index(색인)기능을 통해 자주 사용하는 col에 index를 걸어준다.
# 이걸 사용하면 굉장히 빠른 속도로 검색이 가능하다.
# 데이터를 얼마나 효율적으로 만드는지도 중요하다(modeling)
# 데이터를 백업해주는 것은 필수다.
# 요즘은 클라우드 데이터베이스 서버를 만들 수 있다.