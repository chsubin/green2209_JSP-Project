create table reservation(
	idx int auto_increment, /*고유번호*/
	rvIdx varchar(50) not null, 			/*예약번호*/
	roomIdx int not null, 					/*객실번호*/
	roomName varchar(30) not null, 					/*객실이름*/
	rvDay datetime default now(), 	/*예약 날짜*/
	numOfCustom int default 2, 			/*손님 수 */
	checkIn date not null, 				/*체크인날짜*/
	checkOut date not null, 		/*체크아웃 날짜*/
	rcheckIn datetime null, 				/*실제체크인날짜*/
	rcheckOut datetime null, 		/*실제 체크아웃 날짜*/
	adultF int default 0, 					 /*성인 조식*/
	childF int default 0, 						/*어린이 조식*/
	content varchar(50), 						/*예약 추가 요청*/
	mid varchar(13) null,							/*예약자 아이디*/
	name varchar(10) not null,				 /*예약자 이름*/
	email varchar(30) not null, 			/*예약자 이메일*/
	phoneNumber varchar(13) not null, /*예약자 전화번호*/
	city varchar(10) not null,			 /*거주지*/
	cardName varchar(30) not null, /*카드이름*/
	cardNumber varchar(30) not null,/*카드번호*/
	expiration varchar(10) not null,/*유효기간*/
	rvSw varchar(4) default '예약', /*예약 or 취소 상태 표시*/
	price int not null, 							/* 총합 가격*/
	primary key(idx,rvIdx), 
	foreign key(roomIdx) references hotel(idx) on delete no action,
	foreign key(mid) references member(mid) on delete no action
);
/*멤버 만들기*/
show tables;
drop table reservation;
desc reservation;
select * from reservation;

insert into reservation values (default,'1127-141301',1,'홍길동',default,'2022-12-05','2022-12-06',default);
insert into reservation values (default,'1127-141301',2,'유재석',default,'2022-12-05','2022-12-06',default);
insert into reservation values (default,'1127-141301',2,'박명수',default,'2022-12-05','2022-12-06',default);
insert into reservation values (default,'1127-141301',2,'노홍철',default,'2022-12-05','2022-12-06',default);

select h.*,count(*) as cnt from hotel h,reservation r
where h.idx =r.roomIdx and r.checkIn='2022-12-05'
group by r.idx having cnt<h.numOfRoom;

select h.*,count(*) as cnt from hotel h,reservation r
where h.idx having cnt<h.numOfRoom;
/*카운트하기!!!*/
select h.*,count(*) as cnt from hotel h,reservation r
where r.roomIdx=h.idx 
group by r.roomIdx;

/*222 ..마감이라고 써놓기!!!*/
select h.*,count(*) as cnt from hotel h,reservation r
where r.roomIdx=h.idx and r.checkIn='2022-12-05'
group by r.roomIdx having (cnt=h.numofRoom);


/*연습*/
select h.*,count(*) as cnt from hotel h,reservation r
where r.roomIdx!=h.idx
group by r.roomIdx;
select h.*,r.* from hotel h,reservation r
where r.roomIdx!=h.idx;

select h.*,r.* from hotel h,reservation r;

select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx and r.checkIn='2022-12-05' group by r.roomIdx having (cnt=h.numofRoom);
/*체크인 체크아웃 겹치지않게*/
select h.*,count(*) as cnt from hotel h,reservation r 
where r.roomIdx=h.idx 
and ((r.checkIn<'2022-12-06' and r.checkIn>='2022-12-05')or(r.checkOut>'2022-12-05' and r.checkOut<='2022-12-06'))
group by r.roomIdx having (cnt=h.numofRoom);

select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx and ((r.checkIn<? and r.checkIn>=?)or(r.checkOut>? and r.checkOut<=?)) group by r.roomIdx having (cnt=h.numofRoom);

select * from reservation where mid='admin' order by rvDay desc limit 1,3;
select * from reservation order by rvDay;


select * from reservation where date_format(checkIn, '%Y-%m')='2022-12';

select * from reservation where checkIn<='2023-01-12' and checkOut>'2023-01-12' and rvSw='예약';

select * from reservation;

update reservation set rcheckIn ='2022-12-06 10:00:00' where idx=1;

select * from member;


drop table coupon;



insert into coupon values(1,'admin','20221201','20221219','30000원권 쿠폰',30000,'객실 예약 시 사용 가능합니다');