create database test1;

use test1;

create table memberList(
num           int                  							unique auto_increment,
uId            char(20)          							primary key,
uPw           char(20)           						not null,
uName       char(20)            						not null,
uEmail       char(20)          		 				   not null,
uPhone      char(20)          							not null,
uAge          int                    					    null,
uAddr		 char(100)         						not null,
uGender      int                    						not null, #남자 1, 여자 2, 선택안함 3
uBirth         char(20)           					    not null,
recoPerson   char(20)           						null,
joinTM       timestamp        						not null
);
##drop table memberList;
desc memberList;

select *from memberList order by num desc;

alter table memberList change uAge uAge int null;
alter table memberList change uBirth uBirth char(20) null;
alter table memberList change recoPerson recoPerson char(20) null;


create table adminList(
num              int                  							unique auto_increment,
aId               char(20)                                   primary key,
aPw              char(20)              not null ,
aName          char(20)             not null ,
aEmail          char(20)             not null ,
aPhone         char(20)              not null ,
joinTM          timestamp          not null
);

insert into adminList (aId,aPw,aName,aEmail,aPhone,joinTM) values ('admin','1234','관리자','admin@naver.com','01000000000',now());

select *from adminList order by num desc;

##drop table adminList;

create table goodsTbl(
num					int				unique auto_increment	,
regId			char(20)   		not null,								#작성자 ID
pName				nchar(50)			not null						,
pType				nchar(30) 	not null							,				/*pType : 상품분류*/
stockVolumn		int					not null						,				/*stockVolumn: 재고*/
salesVolumn		int					null						,				/*salesVolumn : 판매량*/
oriPrice				int					not null						,				/*oriPrice 원래 가격*/
sellPrice				int					not null						,				/*sellPrice 실제 판매 가격*/
sellLabel			char(5)				not null						,				/*sellLabel : BEST, NEW, SALE, NONE. 라벨에 대해서 2진법으로 표현(0100)*/
content				text					null						,
regTM				datetime		not null							,
readCnt				smallint(7) unsigned	not null				,				/*count : 조회수*/
oriFileName		char(30)		null								,
sysFileName		char(30)		null								,
fileSize				int(11)			null							
);

desc goodsTbl;

select * from goodsTbl order by num desc;
select * from goodsTbl order by num desc;

 -- drop table goodsTbl;



create table reviewTbl (
totalReviewNum		int			unique auto_increment,		#totalReviewNum 총 review 번호
tblReviewNum			int			not null,							#tblReviewNum 상품별 review 번호
prodNum				int			not null,							#prodNum 상품번호
regId						char(30)	not null,
regName				char(30)	not null,
subject					char(50)	not null,
content					text			null,
regDate				datetime		not null							,
ip						char(30)			not null,	
love					int				null								,
oriFileName		char(30)		null								,
sysFileName		char(30)		null								,
fileSize				int(11)			null			
			
);

desc reviewTbl;
# drop table reviewTbl;

select * from reviewTbl;

create table reviewRecommed (
num						int				unique auto_increment,
totalReviewNum		int				not null,
presserId				char(30)		not null,
recommendTM					timestamp		not null   					
);

desc reviewRecommed;

select * from reviewRecommed;

drop table reviewRecommed;


create table cart(
num					int				unique auto_increment,
uId					char(30)		not null,
pNum				int				null,
pVolumn			int				null
-- foreign key (uId) references memberList(uId),
-- foreign key (pNum) references goodsTbl(num)						
);

desc cart;


select * from cart;

 -- drop table cart;

create table wishlist (
num				int				unique auto_increment,
uId				char(30)		not null,
pNum			int				null
-- foreign key (uId) references memberList(uId),
-- foreign key (pNum) references goodsTbl(num)			
);


desc wishlist;


select * from wishlist;

-- drop table wishlist;

create table uOrder (
	num					int				unique auto_increment,		#num 주문번호
    orderId				char(30)		not null,
    delivAdd			char(100)      not null,			#delivAdd 배송주소
    goodsPay			int				not null,			#goodsPay 총상품가격
    delivFee				int				not null	,			#delivFee 배송비
    totalPay				int				not null,			#totalPay 총결제금액
    payWay				char(30)		not null,			#payWay 지불수단
    ordetStatus		char(30)		null		,
    orderTM				char(30)		null 		
/*    foreign key (orderId) references memberList(uId) */
);

desc uOrder;

select * from uOrder;

#drop table uOrder;

create table orderGoods (
num			int			unique	auto_increment,
orderNum	int			not null,
pNum		int			not null,
pVolumn	int			not null
/*foreign key (orderNum) references uOrder(num),
foreign key (pNum) references goodsTbl(num)	*/	
);

desc orderGoods;

select * from orderGoods;

-- drop table orderGoods;


create table inquireTbl (
num			int					unique auto_increment,    	#글번호
uid			char(20)   		not null,								#작성자 ID
uName		char(30)			not null,								#이름
bbsPw		char(20)			not null,								#게시글비밀번호
subject 	char(50)  			not null,								#제목
qnaType		char(10)			not null,								#QNA유형
content 		text					not null,								#내용
pos          int                    null,										#답변글용(position, 답변글 순서)
ref            int                    null,										#답변글용(reference, 원본글/답변글 기준)
depth        int                    null,										#답변글용(답변글 들여쓰기)
regTM    	timestamp 		not null,								#게시글 등록시간
ip				char(30)			not null,								#게시글 작성자 IP주소
readCnt     int        		    not null,								#조회수
oriFileName char(30)          null,								#첨부파일 원본이름
systemFileName char(200)	 null,								#첨부파일 시스템저장이름
fileSize      int                    null										#첨부파일 크기
);

desc inquireTbl;
select * from inquireTbl order by num desc;

 -- drop table inquireTbl;


create table adminWriteTbl (
num         int               unique auto_increment,       #글번호
aName      char(30)         not null,                        #이름
asubject    char(50)           not null,                        #제목
acontent    text               not null,                        #내용
pos          int                    not null,                              #답변글용(position, 답변글 순서)
ref            int                    not null,                              #답변글용(reference, 원본글/답변글 기준)
depth        int                    not null,                              #답변글용(답변글 들여쓰기)
regTM       timestamp       not null,                        #게시글 등록시간
ip            char(30)         not null,                        #게시글 작성자 IP주소
readCnt     int                  not null,                        #조회수
oriFileName char(30)          null,                        #첨부파일 원본이름
systemFileName char(200)    null,                        #첨부파일 시스템저장이름
fileSize      int                    null                              #첨부파일 크기
);

desc adminWriteTbl;
select * from adminWriteTbl order by num desc;

create table OftenTbl(
num  int unique unique auto_increment,
aId  char(30)   not null,
aName      char(30)         null,                        #이름
subject    char(50)           not null,                        #제목
qnaType		char(10)			not null,					   #QNA유형
content    text               not null,                       #내용
regTM       timestamp       not null,                          #게시글 등록시간
readCnt     int                  not null,                     #조회수
fileName	char(50)			null,
fileSize      int                    null                      #첨부파일 크기
);

 insert into OftenTbl (aId,aName,subject, qnaType ,content, 
 regTM,readCnt, fileName, fileSize) values ('abc','def','qqq', 'qwe', 'ccc', now(),0, '', 0);
select * from OftenTbl order by num desc;
drop table OftenTbl;
drop database test1;