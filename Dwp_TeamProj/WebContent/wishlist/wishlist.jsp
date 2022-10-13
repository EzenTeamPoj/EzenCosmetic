<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="pack_ProdBoard.WishlistBean"%> 
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String aId_Session = (String)session.getAttribute("aId_Session"); 

	
	String pattern = "#,###원";
	DecimalFormat df = new DecimalFormat(pattern);
	
	
	///////////////////////페이징 관련 속성 값 시작///////////////////////////
	//페이징(Paging) = 페이지 나누기를 의미함
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
			
			
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
		start = (nowPage * numPerPage) - numPerPage;
		end = numPerPage;            
	}
			
	totalRecord = objBoard.getTotalWishlistCnt(uId_Session);   
	// 전체 데이터 수 반환
	
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	///////////////////////페이징 관련 속성 값 끝///////////////////////////
	
	Vector<WishlistBean> objList = null;
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>위시리스트 페이지</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/wishlist_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_Wishlist.js"></script>
	</head>
	<body>
	  	<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
			<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  		</header>
		<div id="wrap" class="dFlex wishlistWrap" >
		<!-- 수정함 -->
    		<div id="sideMenu">
          <ul class="List">
	     <li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	     <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	     <li><a href="/order/orderList.jsp">주문내역</a></li>
	     <li><a href="/bbs_Inquire/list.jsp" id="inq">1대1문의</a></li>  
	       <hr>
	      <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	      <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
	   </ul>
    	</div>
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">
	    			<div id="title" class="dFlex">
	    				<img src="/img/wishlist_icon.png" alt="위시리스트 이미지" width="40" height="40">
	    				<!-- 수정함 -->
		    			<h1>위시리스트</h1>
	    			
	    			</div>
	    			<div id="pageInfo" class="dFlex">
						<span>총 :  <%=totalRecord%> 개</span>
						<span>페이지 :  <%=nowPage + " / " + totalPage%></span>  
					</div>	
		    			<table id="wishlistTbl">
							<tbody>
								<tr>
									<th>
										<label>
											<input type="checkbox" id="chkAll">
											<span>전체선택</span>								
										</label>
									</th>
									<th>상품정보</th>
									<th>상품금액</th>
									<th>&nbsp;</th>
								</tr>
								<%
								objList = objBoard.getWishlist(start, end, uId_Session);  // DB에서 데이터 불러오기
								listSize = objList.size();			
								
									if (objList.isEmpty()) {
										// 데이터가 없을 경우 출력 시작
									%> 
										<tr>
											<td colspan="4">
											<%="게시물이 없습니다." %>
											</td>
										</tr>				
									<%
										// 데이터가 없을 경우 출력 끝
									} else {
										// 데이터가 있을 경우 출력 시작
								%>
								<%
								for (int i=0; i<numPerPage; i++) {		
									
									if(i==listSize) break;
									 WishlistBean objBean = objList.get(i);
									 
									 int num = objBean.getNum();
									 String sysFileName = objBean.getSysFileName();
									 int pNum = objBean.getpNum();
									 String pName = objBean.getpName();
									 int sellPrice = objBean.getSellPrice();
								%>
								<tr>
									<td>
										<label>
											<input type="checkbox" class="chkOne">
											<img src="/fileUpload/<%=sysFileName %>" alt="상품이미지" width="100" height="100">
										</label>
									</td>
									<td>
										<a href="/product/prodRead.jsp?num=<%=pNum%>" class="pNamePrn"><%=pName%></a>
										<!-- 수정함 -->
										<input type="hidden" name ="pName" value="<%=pName%>">
										<input type="hidden" value="<%=num %>" form="multiDelFrm" class="delNum">
										<input type="hidden" value="<%=pNum%>" form="cartMulInsertFrm" class="pNum">
									</td>
									<td><%=df.format(sellPrice) %></td>
									<td>
										<button type="button" class="oneDelBtn">&times;</button>
									</td>
		
								</tr>
							<%} //for end %>
					<%} //if end %>
					
					
						</tbody>
						<tfoot>
							<tr>
								<td colspan="1">
									<button type="button" id="multiDelBtn" form="multiDelFrm">선택삭제</button>
								</td>
								<td colspan="3">
									<button type="submit" class="cartInsertBtn" form="cartMulInsertFrm">장바구니에 담기</button>
								</td>
							</tr>
							<tr id="listPagingArea">
							
						<!-- 페이징 시작 -->
							<td colspan="4" id="pagingTd">
					<%
						int pageStart = (nowBlock - 1 ) * pagePerBlock + 1;
		
						int pageEnd = (nowBlock < totalBlock) ? 
														pageStart + pagePerBlock - 1 :  totalPage;
						                                        
						if (totalPage != 0) {   //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
							// #if01_totalPage   
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
							
							</td>
						</tr>
						</tfoot>
					</table>
			
			
	    		</div>
	    	<!-- 실제 작업 영역 끝 -->
    		</main>
    		    	

		
		</div>
		<!-- div#wrap -->
		<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
		
		<form action="/wishlist/wishMulDelProc.jsp" id="multiDelFrm"></form>
		<form action="/cart/cartMulInsertProc.jsp" id="cartMulInsertFrm"></form>
	</body>
</html>