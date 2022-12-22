create table member(
	idx int not null auto_increment,/*___*/
	mid varchar(13) not null,					/*아이디*/
	pwd varchar(100) not null,				/*비밀번호*/
	nameKor varchar(20) not null,     /*한글이름*/
	nameEng varchar(20) not null,     /*영어이름 이름과 성 사이는 공백으로 받겠다. 나머지 허용X*/
	gender varchar(5) default '남자',  /*성별*/
	birthday date not null,						/*생일*/
	email varchar(40) not null,				/*이메일주소*/
	phoneNumber varchar(13) not null, /*핸드폰번호*/
	homeNumber varchar(14),/*자택번호*/
	address varchar(50),						/*자택주소*/
	level int default 3, 						/*관리자(0),운영자(1), vip(2), 일반회원(3) vip면 10퍼센트 할인*/
	point int default 1000, 	/*포인트*/
	memPoint int default 1000, /*누적포인트  숙소가격의 1퍼센트 적립 50,000포인트 모이면 VIP*/
	startDate datetime default now(), /*가입일*/
	lastDate datetime default now(), /*마지막 방문일*/
	userDel char(2) default 'NO', /*회원 탈퇴 여부 OK 탈퇴 no 가입상태*/
	primary key(idx),
	UNIQUE KEY unique_name (mid)		
);

desc member;
select * from member;
/*delete from member */
drop table member;

update member set lastDate=now() where mid='admin';

select * from member where mid like '%pms%'  order by idx desc limit 0,5;

drop table reservation;

create table reservation(
	idx int auto_increment, /*고유번호*/
	rvIdx varchar(50) not null, 			/*예약번호*/
	roomIdx int not null, 					/*객실번호*/
	rvDay datetime default now(), 	/*예약 날짜*/
	numOfCustom int default 2, 			/*손님 수 */
	checkIn datetime not null, 				/*체크인날짜*/
	checkOut datetime not null, 		/*체크아웃 날짜*/
	rcheckIn datetime null, 				/*실제 체크인 일시*/
	rcheckOut datetime null, 		/*실제 체크아웃 일시 */
	adultF int default 0, 					 /*성인 조식*/
	childF int default 0, 						/*어린이 조식*/
	mid varchar(13) null,							/*예약자 아이디*/
	name varchar(10) not null,				 /*예약자 이름*/
	email varchar(30) not null, 			/*예약자 이메일*/
	phoneNumber varchar(11) not null, /*예약자 전화번호*/
	city varchar(10) not null,			 /*거주지*/
	cardName varchar(10) not null, /*카드이름*/
	cardNumber varchar(20) not null,/*카드번호*/
	expiration varchar(10) not null,/*유효기간*/
	rvSw varchar(4) default '예약', /*예약 or 취소 상태 표시*/
	price int not null, 							/* 총합 가격*/
	primary key(idx,rvIdx), 
	foreign key(roomIdx) references hotel(idx) on update restrict,
	foreign key(mid) references member(mid) on update restrict
);
select * from member order by idx desc limit 0,5 where mid like '%pms%';


show tables;

create table hotel(
	idx int auto_increment primary key, /*인덱스 번호*/
	part varchar(30) not null, /*스탠다드,이그제큐티브,스위트*/
	name varchar(30) not null, /*이름 ex) 스탠다드 디럭스*/
	price int default 150000, /*가격*/
	content text not null,/*설명*/
	roomView varchar (30) not null, /*전망*/
	bed varchar(30) not null, /*침대*/
	size varchar(10) not null, /*방사이즈*/
	formation varchar(50) not null, /*방 구성*/
	numOfRoom int default 3, /*방수*/
	numOfCustom int default 2,/*기준인원*/
	imgPath varchar(200)			/*파일*/
);





insert into hotel values (default,'Standard','27',default,default,'1');
insert into hotel values (default,'Deluxe','27',default,default,'2');
insert into hotel values (default,'Business Deluxe','43',320000,default,'3');
insert into hotel values (default,'Grand Corner Deluxe','51',380000,default,'4');
insert into hotel values (default,'Executive Business Deluxe','43',380000,default,'5');
insert into hotel values (default,'Corner Suite ','68',630000,default,'6');

delete from hotel where idx=6;
select * from hotel;

drop table hotel;

create table reservation(
	idx int auto_increment, /*고유번호*/
	rvIdx varchar(50) not null, 			/*예약번호*/
	roomIdx int not null, 					/*객실번호*/
	rvDay datetime default now(), 	/*예약 날짜*/
	numOfCustom int default 2, 			/*손님 수 */
	checkIn datetime not null, 				/*체크인날짜*/
	checkOut datetime not null, 		/*체크아웃 날짜*/
	adultF int default 0, 					 /*성인 조식*/
	childF int default 0, 						/*어린이 조식*/
	mid varchar(13) null,							/*예약자 아이디*/
	name varchar(10) not null,				 /*예약자 이름*/
	email varchar(30) not null, 			/*예약자 이메일*/
	phoneNumber varchar(11) not null, /*예약자 전화번호*/
	city varchar(10) not null,			 /*거주지*/
	cardName varchar(10) not null, /*카드이름*/
	cardNumber varchar(20) not null,/*카드번호*/
	expiration varchar(10) not null,/*유효기간*/
	rvSw varchar(4) default '예약', /*예약 or 취소 상태 표시*/
	price int not null, 							/* 총합 가격*/
	primary key(idx,rvIdx), 
	foreign key(roomIdx) references hotel(idx),
	foreign key(mid) references member(mid)
);

select * from reservation where date_format(checkIn, '%Y-%m')='2022-12';

select * from member;
