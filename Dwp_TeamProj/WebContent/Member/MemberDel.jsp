<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>Insert title here</title>
	  <link rel="stylesheet" href="/style/common_style.css">
	  <link rel="stylesheet" href="/style/memberDel.css">
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
	<div id="DelWrap" class="dFlex">
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
	<form action="/Member/MemberDel_Proc.jsp">
	 <fieldset id="delField">
	 <legend>비밀번호 확인</legend>
	  비밀번호 <input type="password" id="pw">
	  <button>전송</button>
	 </fieldset>
	 </form>
	</div>
	 <iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0></iframe>
	<!--div#wrap-->
  </body>
</html>