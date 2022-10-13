<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String uId_Session_MLTmp = (String)session.getAttribute("uId_Session");
request.setCharacterEncoding("UTF-8");

String gnbParam = "";
if (request.getParameter("gnbParam") != null) {
	gnbParam = request.getParameter("gnbParam");
}

%>    

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인영역 LNB 메뉴</title>
</head>
<body>

	<nav id="mainLNB">
		<ul id="lnbMainMenu">
		
    		 <% if (gnbParam.equals("myPage")) { %>
	    		<li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	            <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	            <li><a href="">주문현황</a></li>
	            <li><a href="/bbs_Inquire/inquirebbs.jsp" id="inq">1대1문의</a></li>  
	            <hr>
	            <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	            <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
			<% } else { %>    		     		 
	           <li><a href="/bbs_Inquire/inquirebbs.jsp" id="inq">1대1문의</a></li>  
	            <hr>
	           <li><a href="/Member/MemberDel.jsp" id="del">회원목록</a></li>
	           <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
    		 <% } %>    			
		</ul>
	</nav>
	
</body>
</html>