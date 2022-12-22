show tables;
desc pds;

create table pds (
  idx   int not null auto_increment,	/* 자료실 고유번호 */
  mid   varchar(20) not null,					/* 올린이 아이디 */
  midName   varchar(20) not null,					/* 올린이 성명 */
  rvIdx varchar(50) not null, 				/*예약 번호*/
 	roomIdx int not null,								/*예약한 객실 번호*/
 	roomName varchar(30) not null, 			/*예약한 객실 이름*/
 	checkIn date not null, 				/*체크인날짜*/
	checkOut date not null, 		/*체크아웃 날짜*/
  fName			varchar(300) not null,		/* 업로드 파일명 */
  fSName		varchar(300) not null,		/* 실제 파일서버에 저장되는 파일명 */
  title			varchar(100) not null,		/* 업로드 파일의 제목 */
  fDate			datetime default now(),		/* 파일 업로드한 날짜 */
  content   text,											/* 업로드 파일의 상세설명 */
  hostIp		varchar(50) not null,			/* 업로드 PC IP */
  readNum		int default 0,			/* 조회수 */
  primary key (idx) 									/* 기본키 : 자료실의 고유번호 */
);

create table pdsReply (
  idx		int not null auto_increment,	/* 댓글의 고유번호 */
  pdsIdx int not null,							/* 원본글의 고유번호(외래키로 지정) */
  mid			 varchar(13) not null,			/* 댓글 올린이의 아이디*/
  rDate		 datetime default now(),		/* 댓글 올린 날짜 */
  content  text not null,							/* 댓글 내용 */
  primary key(idx),
  foreign key(pdsIdx) references pds(idx) /*폴리곤키!!*/
  /* on update cascade */
  /* on delete restrict */
  /* on delete set null */
);

insert into pdsReply values(default,1,'admin',default,'아주아주 알찼습니다!');

select p.*  from pdsReply r,pds p;

select *,count(r.pdsIdx where p.idx = r.pdsIdx) from pds p,pdsReply r ;

SELECT 	*,datediff(now(), fDate) as day_diff, timestampdiff(hour, fDate, now()) as hour_diff,
 (select count(*)  from pdsReply r where pds.idx = r.pdsIdx) as replyCnt 
FROM pds ;


drop table pds;
desc pds;

delete from pds;

insert into pds values (default,'admin','관리자','22121111-332401',1,'스탠다드 디럭스','2022-12-15','2022-12-16','','',0,'서비스 시작',default,'후기 게시판을 오픈합니다.','192.20.50.41',default);

select * from pds;

select * from reservation;

select * from pds order by idx desc;


drop table reservation;


