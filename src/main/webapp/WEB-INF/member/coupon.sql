create table coupon (
  idx   int not null auto_increment,	/* 쿠폰 고유번호 */
  mid   varchar(20) not null,					/* 올린이 아이디 */
 	startDay datetime default now(), 					/*쿠폰 발급 일시*/
	lastDay date not null, 							/*쿠폰 유효기간*/
  title			varchar(100) not null,		/* 업로드 파일의 제목 */
  price			int default 30000,		/* 쿠폰 가격 */
  content   text,							/* 업로드 파일의 상세설명 */
  useSw varchar(4) default '미사용',
  primary key (idx) 									/* 기본키 : 자료실의 고유번호 */
);
select * from coupon;
