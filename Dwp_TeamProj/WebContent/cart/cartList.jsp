<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="pack_ProdBoard.CartBean"%> 
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String aId_Session = (String)session.getAttribute("aId_Session"); 

	List<CartBean> objList = objBoard.getCartList(uId_Session);
	
	String pattern = "#,###원";
	DecimalFormat df = new DecimalFormat(pattern);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>장바구니 페이지</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/cartList_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_Cart.js"></script>
	</head>
	<body>
	<% if(uId_Session!=null) {	%>
	  	<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
			<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  		</header>

		<div id="wrap" class="dFlex cartListWrap">
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
    		<main id="main">
	    	
	    		<div id="contents" class="bbsList">
	    			<div id="title"  class="dFlex">
		    			<img src="/img/Cart.png" alt="장바구니 이미지"  width="40" height="40"/>
		    			<h1>장바구니</h1>		
	    			</div>
		    		<table id="cartTbl">
							<tbody>
								<tr>
									<th>
										<label>
											<input type="checkbox" id="chkAll">
											<span>전체선택</span>								
										</label>
									</th>
									<th colspan="3">상품정보</th>
									<th>상품금액</th>
									<th>&nbsp;</th>
								</tr>
				
								<%
								 for(int i = 0 ; i< objList.size(); i++){
									 CartBean objBean = objList.get(i);
									 
									 int num = objBean.getNum();
									 String sysFileName = objBean.getSysFileName();
									 int pNum = objBean.getpNum();
									 String pName = objBean.getpName();
									 int sellPrice = objBean.getSellPrice();
									 int pVolumn = objBean.getpVolumn();
									 int stockVolumn = objBean.getStockVolumn();
								%>
								<tr>
									<td>
										<label>
											<input type="checkbox" class="chkOne">
											<input type="hidden" value="<%=sellPrice*pVolumn %>" class="prodPay">
											<input type="hidden" value="<%=sellPrice%>" class="sellPrice">
											<img src="/fileUpload/<%=sysFileName %>" alt="상품이미지" width="100" height="100">
										</label>
									</td>
									<td>
										<a href="/product/prodRead.jsp?num=<%=pNum%>" class="pNamePrn"><%=pName%></a>
										<!-- 수정함 -->
<%-- 										<input type="hidden" name = "pNum" value="<%=pNum%>" form="orderFrm"> --%>
									<%-- 	<input type="hidden" name ="pName" value="<%=pName%>"> --%>
										<input type="hidden" value="<%=num %>" form="multiDelFrm" class="num">
										<input type="hidden" value="<%=num %>" form="orderFrm" class="cartNumOrder">
									</td>
									<td><%=df.format(sellPrice) %></td>
									<td>
										<button type="button" class="volumnDownBtn">-</button>
										<input type="number" class="orderVolumn" value="<%=pVolumn %>">
										<button type="button" class="volumnUpBtn">+</button>
										<input type="hidden" class ="stockVolumn" value="<%=stockVolumn%>">
									</td>
									<td class="prodPay"><%=df.format(sellPrice*pVolumn) %></td>
									<td>
										<button type="button" class="oneDelBtn">&times;</button>
									</td>
		
								</tr>
							<%}%>
					
					
					
						</tbody>
						<tfoot>
							<tr>
								<td>
									<button type="button" id="multiDelBtn" form="multiDelFrm">선택삭제</button>
								</td>
								<td colspan="5">
								 	<span>총 상품가격</span>
								 	<span class="totalProdPrice">0원</span>
								 	<input type="hidden" name="goodsPay" class="totalProdPrice" form="orderFrm">
								 	<span>+</span>
								 	<span>총 배송비</span>
								 	<span class="totaldelivFee">0원</span>
								 	<input type="hidden" name="delivFee" class="totaldelivFee" form="orderFrm">
								 	<span>=</span>
								 	<span>총 주문금액</span>
								 	<span class="totalPayment">0원</span>
								 	<input type="hidden" name="totalPay" class="totalPayment" form="orderFrm">
	
								</td>
							</tr>
							<tr>
								<td colspan="6">
									<input type="hidden" name="uId" value="<%=uId_Session%>" form="orderFrm">
									<input type="hidden" name="flag" value="m" form="orderFrm">
									<button type="submit" id="orderMoveBtn" form="orderFrm">구매하기</button>
								</td>
							</tr>
						</tfoot>
				</table> 	
			
			
	    		</div>
	    	<!-- 실제 작업 영역 끝 -->
	    	</main>
	    	<!-- main#main -->
    		    	

		
		
		</div>
		<!-- div#wrap -->
		
		<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
		
		<form action="/order/order.jsp?" id="orderFrm"></form>
		<form action="/cart/cartMulDelProc.jsp" id="multiDelFrm"></form>
		<iframe width="0" height="0" class="cartModIfr" style="display: none"></iframe>
	<%}else{%>
	 <script>
	 alert("로그인 후 이용이 가능합니다")
	 location.href="/Member/Login.jsp";
	 </script>
	<%}%>
	</body>
</html>