<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
    <%
    
    String uId_Session= (String)session.getAttribute("uId_Session");
    String aId_Session= (String)session.getAttribute("aId_Session");
    %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>Insert title here</title>
	  <link rel="stylesheet" href="/style/indd.css">
	  <link rel="shortcut icon" href="#">
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script src='https://kit.fontawesome.com/a076d05399.js'></script>
	  <script src ="/script/script_main_Script.js"></script>
	  <script src="/script/srcipt_Search.js"></script>
	</head>
  <body>
     <div id="header-wrapper">
	 	<header id="pageHeader">
	 		<div id="headerTopArea">
	 			<div id="main-penel-top">
				 <% if (uId_Session == null && aId_Session == null) { %>
				 <ul class="dFlex">
				   <li><button type="button" id="homeBtn">홈</button></li>
				 	<li class="bar">|<li>
				 	  <li>
				 	      <button type="button" id="joinBtn">회원가입</button>
				 	  </li>
				 	        <li class="bar">|<li>
				 	  <li>
				 	       <button type="button" id="loginBtn">로그인</button>
				 	  </li>
				 	        <li class="bar">|<li>
				 	  <li>
				 	        <button type="button" id="MypageBtn">마이페이지</button>
				 	  </li>
				 	         <li class="bar">|<li>
				 	  <li>
				 	       <button type="button" id="InquireBtn">고객센터</button>
				 	 </li>
				 	        <li class="bar">|<li>
				 	 <li>
				 	      <button type="button" id="PrListBtn">상품게시판</button>
				 	 </li>
				 </ul>
				 <% } else if (uId_Session != null || aId_Session != null) { %>
				 <ul class="dFlex">
				 	<li>
				 		<button type="button" id="homeBtn">홈</button>
				 	</li>
				 	<li class="bar">|<li>
				 	<li>
				 		<button type="button" id="logOutBtn">로그아웃</button>
				 	</li>
				 	<li class="bar">|<li>
				 	<li>
				 		<button type="button" id="MypageBtn">마이페이지</button>
				 	</li>
				 	<li class="bar">|<li>
				 <% 	if (aId_Session != null) { %>
				 	<li>
				 		<button type="button" id="MemberListBtn">회원목록/수정/탈퇴</button>
				 	</li>
				 	<li class="bar">|<li>
					 
				<%  } %>
				 	<li>
				 		<button type="button" id="InquireBtn">고객센터</button>
				 	</li>
				 	<li class="bar">|<li>
				 	<li>
				 		<button type="button" id="PrListBtn">상품게시판</button>
				 	</li>
				 	<li class="bar">|<li>
				 	<li>
				 	<button type="button" id="OftenBtn">자주하는질문</button>
				 	</li>
				 </ul>
				 <%}%>
				 </div>
			 <!-- div#main-penel-top -->
			 </div>
			 <!-- div#headerTopArea -->
		     <div id="headerContentArea" class="dFlex">
				 <div id="headerLogoArea">	
				 	<img src="/img/Logo.png" alt="로고" />
				 </div>
			 	<!-- div#headerLogoArea -->
			 	<div id="headerSideArea" class="dFlex">
			 		<div id="SearchArea">
			 			<div class="box">
						    <form name="search" class="dFlex">
							    <div>
									<select name="typeSearch" id="typeSearch">
										<option>전체</option>
										<option>스킨케어</option>
										<option>로션</option>
										<option>핸드크림</option>
										<option>기타</option>
									</select>
								</div>
						        <input type="text" class="input" name="txt" id="pKeyWord">
						    </form>
		        			<i class='fas fa-search'></i>
						</div>
						<!-- div.box 끝 -->
					</div>
					<!-- div#SearchArea 끝 -->
					 <!-- div#Search -->
					 <!-- icon 추가(아이콘 저작권) -->
					<!--"https://www.flaticon.com/kr/free-icons/" title="사람 아이콘">사람 아이콘  제작자: alfanz - Flaticon-->
					<!--"https://www.flaticon.com/kr/free-icons/" title="위치 아이콘">위치 아이콘  제작자: bearicons - Flaticon -->
					<!--"https://www.flaticon.com/kr/free-icons/-" title="쇼핑 카트 아이콘">쇼핑 카트 아이콘  제작자: Andy Horvath - Flaticon-->
	 				<div id="iconArea" class="dFlex">
	 					<div class="iconImg" id="mypageImg">
	 						<img src="/img/PersonImg.png" alt="마이페이지 이미지" />
	 					</div>
	 					<div class="iconImg" id="cartImg">
	 						<img src="/img/Cart.png" alt="장바구니 이미지" />
	 					</div>    <!-- icon 추가 -->
					 </div>
					 <!-- div#iconArea -->
				 </div> 
				 <!-- div#headerSideArea -->
	 		</div>
	  		<!-- div#headerContentArea -->
	  		<div id="headerBottomArea">
	  			<nav id="headerGNBArea" class="dFlex">
               	<!-- ul#mainMenu>li.mainLi*4>a[href]+ul.subMenu>li.subLi*4>a[href]{$} -->
               		<ul id="mainMenu" class="dFlex">

                    	<li class="mainLi">  <!-- pos:r -->

	                        <a id="allGoods">상품전체</a>
	                        <ul class="subMenu">  <!-- pos:a -->
	                            <li class="subLi"><a class="typeSearch">스킨케어</a></li>
	                            <li class="subLi"><a class="typeSearch">로션</a></li>
	                            <li class="subLi"><a class="typeSearch">핸드크림</a></li>
	                            <li class="subLi"><a class="typeSearch">기타</a></li>
	                        </ul>
                       
                    	</li>
                   		 <li class="mainLi">
                        	<a class="orderBy" data-orderBy="salesVolumn_desc">Best</a>
                    	 </li>
                    	<li class="mainLi">
	                        <a class="orderBy" data-orderBy="num_desc">New</a>
                    	</li>           
               		</ul>
	               	<ul class ="dFlex mainMenu_2">
		               <li class="mainLi_2"><a>OO스토리</a></li>
		               <li class="mainLi_2"><a>이벤트</a></li>
               		</ul>
            	</nav>
		  	</div>
	    </header>
 	</div>
	<!-- div#header-wrapper -->
  </body>
</html>


