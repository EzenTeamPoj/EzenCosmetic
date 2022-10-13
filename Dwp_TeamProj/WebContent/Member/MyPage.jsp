<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<%@page import="java.util.List"%>
<%@page import="pack_Member.MemberBean"%>
<jsp:useBean id="objMgr" class="pack_Member.MemberMgr" scope= "page"/>
<%
String uId_Session = (String)session.getAttribute("uId_Session"); 
String aId_Session = (String)session.getAttribute("aId_Session");
String uId = request.getParameter("uId");
List<MemberBean> objList = objMgr.mtd_Select();
			 
%>

<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>Insert title here</title>
	  <link rel="stylesheet" href="/style/common_style.css">
	  <link rel="stylesheet" href="/style/Mypage.css">
	  <link rel="shorcut icon" href="#">
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script src="/script/script_Member.js"></script>
	</head>
  <body>
	  <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="wrap">
	<% if(uId_Session!=null) {	%>
	<div id="wrap" class="dFlex">
		<div id="sideMenu">
          <ul class="List">
	     <li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	     <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	     <li><a href="">주문현황</a></li>
	     <li><a href="/bbs_Inquire/list.jsp" id="inq">1대1문의</a></li>  
	       <hr>
	      <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	      <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
	   </ul>
    	</div>
	      <div id="myPageContent">
	      <h2>마이페이지</h2>
	      <h3><%out.print(uId_Session);%> 님 반갑습니다</h3>
	      <div id="myContent">
	      <div id="reviewArea">
	       <h3>마이 리뷰</h3>
  	       <p>리뷰 작성하고 혜택까지</p>
  	       <span><a href="#">리뷰작성하러가기</a></span>
	      </div>
	      <!-- div#reviewArea -->
	      </div>
	      <!-- div#myContent -->
	      </div>
	</div>
	<!-- div#wrap -->
     <% } else if (aId_Session!=null) { %>
	     <div id="sideMenu">
          <ul class="List">
	     <li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	     <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	     <li><a href="">주문현황</a></li>
	     <li><a href="/bbs_Inquire/list.jsp" id="inq">1대1문의</a></li>  
	       <hr>
	      <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	      <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
	   </ul>
    	</div>
    	<!-- div#sideMenu -->
     <!-- div#MyPageArea -->
	<%}else{%>
	 <script>
	 alert("로그인 후 이용이 가능합니다")
	 location.href="/Member/Login.jsp";
	 </script>
	<%}%>
	
	</div>
	<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	<!--div#wrap-->
	
  </body>
</html>