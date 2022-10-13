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
int numPerPage = 6;    // 페이지당 출력하는 데이터 수(=게시글 숫자)
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
int end = 6;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
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
		<script src="/script/script_Product.js"></script>
	</head>
	<body>
	  <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="wrap" class="prodListWrap">
    	
		<%
				String prnType = "";
				if (keyWord.equals("null") || keyWord.equals("")) {
					prnType = "전체 상품";
				} else {
					prnType = "검색 결과";
				}
			%>
		<main id="main">
		
			<div id="pageInfo" class="dFlex">
				<div id="tblNumInfo">
					<span><%=prnType %> : <%=totalRecord%> 개</span> 
					<span>현재 페이지 : <%=nowPage + " / " + totalPage%></span>		
				</div>
				<div id="orderArea">
					<ul class="dFlex">
						<li>
							<label>
								<input type="radio" class="orderBy" name="orderBy" value="salesVolumn_desc">
								<span>판매량순</span>
							</label>
						</li>
						<li>|</li>
						<li>
							<label>
								<input type="radio" class="orderBy" name="orderBy" value="sellPrice_asc">
								<span>낮은 가격순</span>
							</label>
						</li>
						<li>|</li>
						<li>
							<label>
								<input type="radio" class="orderBy" name="orderBy" value="sellPrice_desc">
								<span>높은 가격순</span>
							</label>
						</li>
						<li>|</li>
						<li>
							<label>
								<input type="radio" class="orderBy" name="orderBy" value="num_desc">
								<span>최신 등록순</span>
							</label>
						</li>
					</ul>
				</div>
			</div>
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
			<div id="listBtnArea">
				<% if(aId_Session!=null) { %>			
				<button type="button" onclick="location.href='/product/prodPost.jsp'">글쓰기</button>
				<% } %>
				<form name="searchFrm" class="dFlex" id="searchFrm">
		
					<div>
						<select name="typeSearch" id="typeSearch">
							<option value="전체"
								<%if (typeSearch.equals("전체"))
											out.print("selected");%>>전체</option>
							<option value="스킨케어"
								<%if (typeSearch.equals("스킨케어"))
											out.print("selected");%>>스킨케어</option>
							<option value="로션"
								<%if (typeSearch.equals("로션"))
											out.print("selected");%>>로션</option>
							<option value="핸드크림"
								<%if (typeSearch.equals("핸드크림"))
											out.print("selected");%>>핸드크림</option>
							<option value="기타"
								<%if (typeSearch.equals("기타"))
											out.print("selected");%>>기타</option>
						</select>
					</div>
					<div>
						<input type="text" name="keyWord" id="keyWord" id="keyWord"
							size="20" maxlength="30" value="<%=keyWord%>">
					</div>
					<div>
						<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
					</div>
		
				</form>
		
				<!-- 검색결과 유지용 매개변수 데이터시작 --> 
				<input type="hidden" id="nowPage" value="<%=nowPage%>"> 
				<input type="hidden" id="pKeyWord" value="<%=keyWord%>"> 
				<input type="hidden" id="orderBy" value="<%=orderBy%>">
				<input type="hidden" id="typeSearch" value="<%=typeSearch%>"> 
				<!-- 검색결과 유지용 매개변수 데이터끝 -->
			</div>
	
			<div id="listPagingArea">
							
						<!-- 페이징 시작 -->

				
				
					<%
					int pageStart = (nowBlock - 1) * pagePerBlock + 1;
					int pageEnd = (nowBlock < totalBlock) ? pageStart + pagePerBlock - 1 : totalPage;
			
					if (totalPage != 0) { //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
					%>
						
						<% if (nowBlock>1) { 	   // 페이지 블럭이 2이상이면 => 2개이상의 블럭이 있어야 가능 %>
									<span class="moveBlockArea" onclick="moveLeftBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>')">
									&lt; 
									</span>
						<% } else { %>
						            <span class="moveBlockArea" ></span>
						<% } %>
					
						<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
						<% 
						             // 2        <     6                     
							for (   ; pageStart<=pageEnd; pageStart++) { %>
								<% if (pageStart == nowPage) {   // 현재 사용자가 보고 있는 페이지 %>
									<span class="nowPageNum"><%=pageStart %></span>
								<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
								 	<span class="pageNum" onclick="movePage('<%=pageStart %>')">
										<%=pageStart %>
								 	</span>					
								<% } // End If%>		 	
						<% }  // End For%>
						<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
						
					
					<% if (totalBlock>nowBlock) { // 다음 블럭이 남아 있다면  %>
								<span  class="moveBlockArea" onclick="moveRightBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>')">
								&gt;
								</span>
				
					<% } else { %>
					            <span class="moveBlockArea"></span>
					<% } %>
					
						
						
					<%
					} else {
						out.print("<b>[1]</b>"); // End if
					}
					%>
				
				</div>

				
		</main>
		<!-- main#main -->
		</div>
		<!--div#wrap  -->
		<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	</body>
</html>
