# 2.1 몽고디비 셀 경험하기
셀에 mongo를 쓰면 실행된다. (그전에 mongod를 꼭 실행하자.)

몽고디비는 데이터베이스와 컬렉션 모두 가지고 있다.

# 튜토리얼 데이터베이스 사용
use tutorial

## 2.1.3 삽입과 질의

이걸 처음 실행하면 약간의 지연이 느껴지게 되는데, 이는 tutorial 데이터베이스와 users 컬렉션이 하드디스크에 아직 생성되지 않았기 때문에 초기 데이터 파일을 할당하느라 지연된다.
db.users.insert({username:"smith"})

# 컬렉션 확인문
db.users.find()

-> _id라는 필드가 생기게 된다. 프라이머리 키임.
_id 필드가 없으면 몽고디비는 ID라는 특별한 값을 생성해 도큐먼트에 자동으로 추가한다.

# 삽입문
db.users.insert({username:'jones'})

# 컬렉션 카운트
db.users.count()

# 새로 생긴 것을 확인할 수 있다
db.users.find()

아래와 같이 조건문도 생성할 수 있다
db.users.find({username:'jones'})

필드 사이에 암시적인 AND를 만들어낼 수 있다. $and를 써서 명시적으로 나타낼 수도 있다. and를 사용하면 조건과 모두 일치하느 값을 찾아준다
db.users.find({$and : [
{_id : ObjectId('5ebeb37d7a5d1c566f7834be')},
{username:'jones'}]})

OR 연산자도 위와 마찬가지로 $or를 쓰면 된다. 둘 중 하나만 맞아도 찾아준다

db.users.find({$or:[
{username:'jones'},
{username:'smith'}]})

## 2.1.4 도큐먼트 업데이트

update() 매서드로 단일 도큐먼트를 업데이트 할 수 있다
다음은 $set 연산자를 사용해서 업데이트 한다
db.users.update({username:'smith'}, {$set:{country:'Canada'}})
db.users.find()

필드값을 설정하는 것이 아니라 아예 도큐먼트를 다른 것으로 대체할 수 있다
db.users.update({username:'smith'}, {country:'Canada'})
username은 없어지고 country로 대체된다.
전체 도큐먼트를 대체하는 것이 아닌 필드를 추가하거나 값을 성정하기를 원하면 $set를 사용해야한다.
만약 프로파일에 국가 정보를 저장하는 것을 원하지 않으면 $unset을 사용하면된다

db.users.update({username:'smith'},{$unset: {country:1}})
db.users.find({username:'smith'})

db.users.update({username:'smith'},
    {
        $set:{
        favorite:{
            cities:['Chicago','Cheyenne'],
            movies: ['cas','man']
            }
        }
    })

db.users.update({username:'jones'},
    {
        $set:{
        favorite:{
            movies: ['cas','man']
            }
        }
    })

## pretty를 사용하면 예쁘게 확인할 수 있다
# datagrip에서는 사용할 수 없다. 이미 예쁘게 나온다
db.users.find().pretty()

# 다음과 같이 쓰면 favorite 안에 있는 movie에 대해서 찾아달라고 할 수 있다
db.users.find({'favorite.movies':'cas'})

# 특정 리스트에 값을 하나만 추가할 경우 $push나 $addToSet이 더 낫다. $addToSet은 값을 추가할 때 중복되지 않도록 확인한다
db.users.update( {'favorite.movies':'cas'},
    {$addToSet:{'favorite.movies':'maltese'} },
    false,
true)

# 첫번째는 쿼리 셀렉터다.
두번째는 $addToSet을 이용해서 리스트에 추가한다.
세번째는 fasle인데 upsert(update&insert)가 허용되는지 아닌지를 조정한다.
네번째는 true인데 이 업데이트가 다중 업데이트, 즉 하나 이상의 도큐먼트에 대해 업데이트가 이루어져야 함을 뜻한다.
몽고디비는 기본적으로 하나의 컬렉터에만 해준다. 이걸 사용하면 다중으로 가능.

## 2.1.5 데이터 삭제

db.users.remove({'favorite.cities':'Chicago'})

모든 인덱스를 지울떄는 drop()을 사용한다
db.users.drop()

# 2.2 인덱스 생성과 질의

## 2.2.1 대용량 컬렉션 생성

다음과 같은 대용량도 매우 빠르게 만들 수 있다.
for (i =0; i < 20000; i++) {
    db.numbers.save({num:i});
} # datagrip에서는 이게 안됨... 안되는게 많다.

범위 쿼리는 $gt와 $lt를 사용하면 된다. greater than과 less than의 약자다.
db.numbers.find({num:{'$gt':19995}})

# 상한과 하한을 조정할 수 있다.
db.numbers.find({num:{'$gt':20, '$lt':25}})

##  2.2.2 인덱싱과 explain()
explain을 사용하면 디버깅시 매우 유용하다.
db.numbers.find({num:{'$gt':19995}}).explain('executionStats')

createIndex()를 통해 키에 대한 인덱스를 생성할 수 있다.
db.numbers.createIndex({num:1})

getIndexes()를 통해 인덱스를 확인할 수 있다.

# 2.3 기본적인 관리

## 2.3.1 데이터베이스 정보 얻기

show.dbs를 쓰면 db 정보를 알 수 있다
show.collections를 쓰면 모든 컬렉션을 볼 수 있다.
db.stats()를 통해 데이터베이스와 컬렉션에 대해서 좀 더 하위 계층 정보를 알 수 있다.
컬렉션에 대해서도 stats를 실행할 수 있다.
