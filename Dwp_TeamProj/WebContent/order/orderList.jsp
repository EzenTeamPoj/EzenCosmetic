<%@page import="pack_Order.OrderGoodsBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_Order.UOrderBean"%>
<jsp:useBean id="objBoard" class="pack_Order.OrderMgr" /> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
			
	totalRecord = objBoard.getTotalOrderList(uId_Session);   
	// 전체 데이터 수 반환
	
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	///////////////////////페이징 관련 속성 값 끝///////////////////////////
	
	Vector<UOrderBean> objList = null;
	Vector<OrderGoodsBean> objListGoods = null;
	
	int pNum;
	int pVolumn;
	String pName;
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문현황</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/order_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_Order.js"></script>
	</head>
	<body>
	  	<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
			<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  		</header>
		<div id="wrap" class="dFlex orderListWrap" >
		<!-- 수정함 -->
    		<div id="sideMenu">
          <ul class="List">
	     <li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	     <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	     <li><a href="">주문내역</a></li>
	     <li><a href="/bbs_Inquire/list.jsp" id="inq">1대1문의</a></li>  
	       <hr>
	      <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	      <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
	   </ul>
    	</div>
	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">
	    			<div id="title" class="dFlex">
	    				<img src="/img/주문내역.png" alt="주문내역 이미지" width="40" height="40">
	    				<!-- 수정함 -->
		    			<h1>주문내역</h1>
	    			
	    			</div>
	    			<div id="pageInfo" class="dFlex">
						<span>총 :  <%=totalRecord%> 개</span>
						<span>페이지 :  <%=nowPage + " / " + totalPage%></span>  
					</div>	
		    			<table id="orderListTbl">
							<tbody>
								<tr>
									<th>주문번호</th>
									<th>주문상품</th>
									<th>총지불금액</th>
									<th>결제수단</th>
									<th>주문상태</th>
									<th>주문일시</th>
								</tr>
								<%
								objList = objBoard.getOrderList(start, end, uId_Session);  // DB에서 데이터 불러오기
								listSize = objList.size();			
								
									if (objList.isEmpty()) {
										// 데이터가 없을 경우 출력 시작
									%> 
										<tr>
											<td colspan="6">
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
									 UOrderBean objBean = objList.get(i);
									 
									 int num = objBean.getNum();
									 String delivAdd =  objBean.getDelivAdd();
									 int goodsPay = objBean.getGoodsPay();
									 int delivFee = objBean.getDelivFee();
									 int totalPay = objBean.getTotalPay();
									 String payWay = objBean.getPayWay();
									 String ordetStatus = objBean.getOrdetStatus();
									 String orderTM = objBean.getOrderTM();
								%>
								<tr>
									<td><%=num %></td>
									<td>
								<% 	objListGoods = objBoard.selectOrderGoods(num);  // DB에서 데이터 불러오기
										int listGoodsSize = objListGoods.size();	
										for (int j=0; j<listGoodsSize; j++) {		

											 OrderGoodsBean objGoodsBean = objListGoods.get(j);

											 pNum = objGoodsBean.getpNum();
											 pVolumn=objGoodsBean.getpVolumn();
											 pName=objGoodsBean.getpName();
										
								%>
										<div class="dFlex oNameVolumn">
											<div class="oName"><a href="/product/prodRead.jsp?num=<%=pNum%>"><%=pName %></a></div>
											<div class="oVolumn"><%=pVolumn %>개</div>
										</div>
								<%} %>
									</td>
									<td><%=df.format(totalPay) %></td>
									<td><%=payWay %></td>
									<td><%=ordetStatus %></td>
									<td><%=orderTM %></td>
		
								</tr>
							<%} //for end %>
					<%} //if end %>
					
					
						</tbody>
						<tfoot>
							<tr id="listPagingArea">
							
						<!-- 페이징 시작 -->
							<td colspan="6" id="pagingTd">
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
    		
    		</div>
    		
    			<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
    		    	
	</body>
</html>