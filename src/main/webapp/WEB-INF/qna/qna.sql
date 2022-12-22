create table qna(
	idx int not null auto_increment primary key, /*고유번호*/
	nickName varchar(20) not null, /*방문자 성명(알아서 지정)*/
	mid varchar(13), /*아이디*/
	email varchar(60), /*이메일주소*/
	day datetime default now(),/*작성일자*/
	hostIp varchar(50) not null, /*방문자 IP*/
	content text not null /*qna*/
);
drop table qna;

insert into qna values(1,'관리자','관리자','admin@naver.com','2022-12-12','192.50.41','Q&A서비스를 시작합니다.');
insert into qna values(default,'관리자','관리자','admin@naver.com',default,'192.50.41','너와 이 노랠 부르며 마지막 춤을 출거야 이순간을 기억해 언제까지라도');
insert into qna values(default,'관리자','관리자','admin@naver.com',default,'192.50.41','링가링가');

select * from qna;

drop table qnaReply;

select * from qna;

create table qnaReply (
  idx		int not null auto_increment,	/* 댓글의 고유번호 */
  qnaIdx int not null,							/* 원본글의 고유번호(외래키로 지정) */
  mid			 varchar(13) not null,			/* 댓글 올린이의 아이디 어차피 관리자가 작성 or 운영자*/
  rDate		 datetime default now(),		/* 댓글 올린 날짜 */
  content  text not null,							/* 댓글 내용 */
  primary key(idx),
  foreign key(qnaIdx) references qna(idx) /*폴리곤키!!*/
  /* on update cascade */
  /* on delete restrict */
);
drop table qnaReply;
delete from qna;


select * from qnaReply order by qnaidx desc;
select * from qnaReply  where qnaidx>=1 and qnaidx<=5 order by qnaidx desc;
insert into qnaReply values (default,1,'admin',default,'많은 참여 바랍니다.');
insert into qnaReply values (default,1,'admin',default,'질문 많이 해주세요');
insert into qnaReply values (default,3,'admin',default,'vip는 20%할인됩니다.');

delete from qnaReply;

select count(*) as cnt from pds where mid like 'admin' or midName like 'admin';

select * from reservation;

select * from reservation 
where (checkIn<='2022-12-01' and checkOut>='2022-12-01' and rvSw='예약')
or (checkIn<='2022-12-31' and checkOut>='2022-12-31' and rvSw='예약')
or (checkIn>='2022-12-01' and checkOut<='2022-12-31' and rvSw='예약');