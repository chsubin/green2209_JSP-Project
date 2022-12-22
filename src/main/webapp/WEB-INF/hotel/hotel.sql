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
	fName	varchar(300) not null,		/* 업로드 파일명 */
 	fSName	varchar(300) not null		/* 실제 파일서버에 저장되는 파일명 */
);


desc member;
desc hotel;

insert into hotel values
(default,'스탠다드','스탠다드 디럭스',default,'모던한 콘셉트의 아늑한 공간 안에 편안한 휴식을 선사하는 침구와 업무를 위한 책상을 갖추어 효율적인 구성이 돋보이는 객실입니다. 안락한 공간이 주는 편안함과 함께 일상에서 벗어난 듯한 특별한 휴식을 경험해보시기 바랍니다.'
,'남산 또는 시티뷰','더블(킹 사이즈),트윈','36','침실1, 욕실1, 화장실1',default,2,'1.jpg');
insert into hotel values (default,'Deluxe','27',default,default,'2');
insert into hotel values (default,'Business Deluxe','43',320000,default,'3');
insert into hotel values (default,'Grand Corner Deluxe','51',380000,default,'4');
insert into hotel values (default,'Executive Business Deluxe','43',380000,default,'5');
insert into hotel values (default,'Corner Suite ','68',630000,default,'6');

delete from hotel where idx=6;
select * from hotel;

drop table hotel;
drop table reservation;
select * from reservation;

create table reservation(
	idx int auto_increment, /*고유번호*/
	rvIdx varchar(50) not null, 			/*예약번호*/
	roomIdx int not null, 					/*객실번호*/
	roomName varchar(30) not null, 					/*객실이름*/
	rvDay datetime default now(), 	/*예약 날짜*/
	numOfCustom int default 2, 			/*손님 수 */
	checkIn date not null, 				/*체크인날짜*/
	checkOut date not null, 		/*체크아웃 날짜*/
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
	foreign key(roomIdx) references hotel(idx),
	foreign key(mid) references member(mid)
);



create table coupon (
  idx   int not null auto_increment,	/* 쿠폰 고유번호 */
  mid   varchar(20) not null,					/* 올린이 아이디 */
 	startDay datetime default, 					/*쿠폰 발급 일시*/
	lastDay date not null, 							/*쿠폰 유효기간*/
  title			varchar(100) not null,		/* 업로드 파일의 제목 */
  price			int default 30000,		/* 쿠폰 가격 */
  content   text,											/* 업로드 파일의 상세설명 */
  primary key (idx) 									/* 기본키 : 자료실의 고유번호 */
);

select h.*,count(*) as cnt from hotel h,reservation r ;

select h.*,count(*) as cnt from hotel h,reservation r 
where r.roomIdx=h.idx 
and ((r.checkIn<'2022-12-31' and r.checkIn>='2022-12-01')or(r.checkOut>'2022-12-01' and r.checkOut<='2022-12-31') or (r.checkIn<'2022-12-01' and r.checkOut>'2022-12-31') or (r.checkIn>'2022-12-01' and r.checkOut<'2022'))
and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);


select h.*,count(*) as cnt from hotel h,reservation r 
where r.roomIdx=h.idx and ((r.checkIn>='20221201' and r.checkIn<'20221231')or(r.checkOut>'20221201' and r.checkOut<='20221231'))
and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);

select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx and ((r.checkIn<'20221231' and r.checkIn>='20221201')or(r.checkOut>'20221201' and r.checkOut<='20221231')) and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx and ((r.checkIn<'20221231' and r.checkIn>='20221201')or(r.checkOut>'20221201' and r.checkOut<='20221231')) and r.rvSw='예약' ;



select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and ((r.checkIn<'20221222' and r.checkIn>='20221223')or(r.checkOut>'20221222' and r.checkOut<='2022122'))
					  and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
					  
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and ((r.checkIn<'20221223' and r.checkIn>='20221222') or (r.checkOut>'20221222' and r.checkOut<='20221223') or (r.checkIn<='20221222' and r.checkOut>'20221223') or (r.checkIn>'20221222' and r.checkOut<'20221223'))  
					  and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
					  
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and ((r.checkIn<'20221223' and r.checkIn>='20221222') or (r.checkOut>'20221222' and r.checkOut<='20221223') or (r.checkIn<='20221222' and r.checkOut>'20221223') or (r.checkIn>'20221222' and r.checkOut<'20221223'))  
					  and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
					  
					  
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and ((r.checkIn<'20221201' and r.checkIn>='20221')or(r.checkOut>'202212' and r.checkOut<='20221223'))  
					  and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
					  
					  
					  
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and (r.checkIn>'20221201' and r.checkOut<='20220131')
					  and r.rvSw='예약' group by r.roomIdx having (cnt=h.numofRoom);
					  
select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and (r.checkIn>'20221201' and r.checkOut<='20220131');
select * from hotel h, reservation r where r.checkIn>'20221201' and r.checkOut<='20220131';
select * from reservation where checkIn>'20221201' and checkOut<='20230131';
select * from reservation;



select h.*,count(*) as cnt from hotel h,reservation r where r.roomIdx=h.idx
					 and ((r.checkIn<'20230131' and r.checkIn>='20221101')or(r.checkOut>'20221101' and r.checkOut<='20230131'))
				  and r.rvSw='예약' group by r.roomIdx having (cnt>=h.numofRoom);