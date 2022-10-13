<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="pack_ProdBoard.ProdBoardBean" %>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr" />

<%
request.setCharacterEncoding("UTF-8");

String uId_Session = (String)session.getAttribute("uId_Session"); 
String aId_Session = (String)session.getAttribute("aId_Session"); 

///////////////////////페이징 관련 속성 값 시작///////////////////////////
// 페이징(Paging) = 페이지 나누기를 의미함
int totalRecord = 0;        // 전체 데이터 수(DB에 저장된 row 개수)
int numPerPage = 5;    // 페이지당 출력하는 데이터 수(=게시글 숫자)
int pagePerBlock = 5;   // 블럭당 표시되는 페이지 수의 개수
int totalPage = 0;           // 전체 페이지 수
int totalBlock = 0;          // 전체 블록수

 /*  페이징 변수값의 이해 
totalRecord=> 200     전체레코드
numPerPage => 10
pagePerBlock => 5
totalPage => 20
totalBlock => 4  (20/5 => 4)
*/

int nowPage = 1;          // 현재 (사용자가 보고 있는) 페이지 번호
int nowBlock = 1;         // 현재 (사용자가 보고 있는) 블럭

int start = 0;     // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
int end = 5;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
                          // select * from T/N where... order by ... limit start, end;

int listSize = 0;    // 1페이지에서 보여주는 데이터 수
						//출력할 데이터의 개수 = 데이터 1개는 가로줄 1개

// 게시판 검색 관련소스

String keyWord = ""; // DB의 검색어
String orderBy = "num_desc"; // DB 정렬순서
String typeSearch = "전체";  // 제품별 검색어

if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
}

if (request.getParameter("orderBy") != null) {
	orderBy = request.getParameter("orderBy");
}

if (request.getParameter("typeSearch") != null) {
	typeSearch = request.getParameter("typeSearch");
}


						
if (request.getParameter("nowPage") != null) {
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;            
}




totalRecord = objBoard.getTotalCount(keyWord, typeSearch);   
// 전체 데이터 수 반환

totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);

///////////////////////페이징 관련 속성 값 끝///////////////////////////

Vector<ProdBoardBean> vList = null;

String pattern = "#,###원";
DecimalFormat df = new DecimalFormat(pattern);
%>   
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/product_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_main_Script.js"></script>
	</head>
	<body>
	<div id="wrap" class="prodListWrap mainLayout">
    	
	
	


			<ul id="prodBBS" class="dFlex">
				<%
				vList = objBoard.getBoardList(keyWord, start, end, orderBy, typeSearch);  // DB에서 데이터 불러오기
				listSize = vList.size();			
				
					if (vList.isEmpty()) {
						// 데이터가 없을 경우 출력 시작
				%>
	
				<li><%="게시물이 없습니다." %></li>
	
				<%} else{   
					   	
					   	for(int i=0; i<numPerPage; i++) {
							if(i==listSize) break;
							
							ProdBoardBean bean = vList.get(i);
							
							int num = bean.getNum();
							String pName = bean.getpName();
							String sysFileName = bean.getSysFileName();
							int oriPrice = bean.getOriPrice();
							int sellPrice = bean.getSellPrice();
							double discountRate = 100-(double)sellPrice/oriPrice*100;
							
							String discountDisplay = "";
							if(oriPrice==sellPrice) {
								discountDisplay="none";
							} else {
								discountDisplay="inline-block";
							}
							String [] sellLabel = bean.getSellLabel();
							String [] sellLabelDisplay = new String [4];
							for(int j =0; j <sellLabel.length; j ++) {
								if(sellLabel[j].equals("1")) {
									sellLabelDisplay[j] = "inline-block";
								} else if(sellLabel[j].equals("0")){
									sellLabelDisplay[j] = "none";
								}
							}
							
					   	%>
	
				<li class="prod" onclick="read('<%=num%>', '<%=nowPage%>')">
					<div class="prodThum">
						<img src="/fileUpload/<%=sysFileName %>" alt="제품 썸네일" width="230"
							height="230">
					</div> 
					<div class="prodDetail" >
						<div class="label dFlex">					
							<div class="bestLabel" style="display: <%= sellLabelDisplay[0] %>">BEST</div>
							<div class="newLabel" style="display: <%= sellLabelDisplay[1] %>">NEW</div>
							<div class="saleLabel" style="display: <%= sellLabelDisplay[2] %>">SALE</div>
							&nbsp;
						</div>
						<div class="pName"><%=pName %></div>
						<div class="priceArea">
							<div class="discount dFlex">
								<div class="discRate" style="display:<%=discountDisplay%>"><%=(int)discountRate %>%</div> 
								<div class="oPrice" style="display:<%=discountDisplay%>"><%=df.format(oriPrice) %></div>
							</div>
							<div class="sPrice"><%=df.format(sellPrice) %></div> 
						</div>
					</div>
				</li>
				<%} //for End
					   	
				   		} //if  End %>
	
			</ul>
		</ul>



			
			
		</div>
		<!--div#wrap  -->
	</body>
</html>
