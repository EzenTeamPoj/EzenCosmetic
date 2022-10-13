<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
iframe#ifrNotice {
	width: 100%;
	height: 600px;
	
}
iframe#ifrInquire {
width: 100%;
height: 600px;
display: none;
}
</style>
		<link rel="stylesheet" href="/style/common_style.css">
<link rel="stylesheet" href="/style/style_BBS.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Notice.js"></script>

<body>
	 <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="wrap">
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
		<button id="noticeBtn" class="headBtn">공지사항</button>
		<button id="personalBtn" class="headBtn">1:1문의</button>


		<iframe id="ifrNotice" src="/bbs_Notice/noticebbs.jsp" frameborder="0"></iframe>
 		<iframe id="ifrInquire" src="/bbs_Inquire/list_short.jsp" frameborder="0" scrolling="no"> </iframe>
	</div>



	<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
</body>
</html>