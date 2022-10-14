<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<% String uId_Session = (String)session.getAttribute("uId_Session"); 
String aId_Session = (String)session.getAttribute("aId_Session");  %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>Insert title here</title>
	  <link rel="stylesheet" href="/style/common_style.css">
	  <link rel="stylesheet" href="/style/main_style.css">
	  <link rel="stylesheet" href="/style/indd.css">
	  <link rel="shortcut icon" href="#">
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script src="/script/script_Common"></script>
	  <script src="/script/script_main_Script.js"></script>
	</head>
  <body>
  	<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
    
	<div id="wrap">
	 <div id="slideshowArea">
	                <!-- 안녕하세요 주석입니다. -->
	                <!-- 2. 슬라이드 프레임(= 틀) 3600 x 300 -->
	                <div id="slideFrame" class="dFlex">	                
	                
	                	<!-- 3. 이미지 요소를 포함하는 링크요소(a)  1200 x 300-->
	                	<a href="#">   <!--  -->
	                		<img src="/img/Fail_Event.png" alt="슬라이드1">
	                	</a>
	                	
	                	<a href="#">
	                		<img src="/img/launch-ing.png" alt="슬라이드2">
	                	</a>
	                	
	                	<a href="#">
	                		<img src="/img/SampleEvent.png" alt="슬라이드3">
	                	</a>
	                
	                </div>
	                <!-- div#slideFrame -->
	                
	            </div>
	            <!-- div#slideshowArea, 슬라이드 쇼 끝 -->
	            
	           <!--  상품템플릿 시작, iframe으로 변경 -->
	           <div id="GoodsArea">
	           	<div class="iframeArea">
	           		<div>
	           			<h1>인기상품</h1>
	           		</div>
	              	<iframe src="/product/mainLayout_ProdList.jsp?orderBy=salesVolumn_desc"  
	              		scrolling="no" frameborder="0" class="mainProd"></iframe>
	              	<div class="prodMoreMoveBtn">
		              	<button type="button" class="orderBy" data-orderBy = "salesVolumn_desc">상품 더보기</button>	
	              	</div>
	            </div>
	            <div class="iframeArea">
	            	<h1>새로운 상품</h1>
	            	<iframe src="/product/mainLayout_ProdList.jsp?orderBy=num_desc"  
	              		scrolling="no" frameborder="0" class="mainProd"></iframe>
	              	<div class="prodMoreMoveBtn">
		              	<button type="button" class="orderBy" data-orderBy = "num_desc">상품 더보기</button>	
	              	</div>
	              	
	            </div>
	            <div class="iframeArea">
	            	<h1>스킨케어</h1>
	            	<iframe src="/product/mainLayout_ProdList.jsp?typeSearch=스킨케어&orderBy=salesVolumn_desc"  
	              		scrolling="no" frameborder="0" class="mainProd"></iframe>
	            	<div class="prodMoreMoveBtn">
		              	<button type="button" class="typeSearch" data-typeSearch = "스킨케어">상품 더보기</button>		
	              	</div>
	            </div>
	            <div class="iframeArea">
	            	<div></div>
	            	<h1>로션</h1>
	            	<iframe src="/product/mainLayout_ProdList.jsp?typeSearch=로션&orderBy=salesVolumn_desc"  
	              		scrolling="no" frameborder="0" class="mainProd" ></iframe>
	              	<div class="prodMoreMoveBtn">
		              	<button type="button" class="typeSearch" data-typeSearch = "로션">상품 더보기</button>		
	              	</div>
	            </div>
	            <div class="iframeArea">
	            	<h1>핸드크림</h1>
	            	<iframe src="/product/mainLayout_ProdList.jsp?typeSearch=핸드크림&orderBy=salesVolumn_desc"  
	              		scrolling="no" frameborder="0" class="mainProd"></iframe>
	              	<div class="prodMoreMoveBtn">
		              	<button type="button" class="typeSearch" data-typeSearch = "핸드크림">상품 더보기</button>		
	              	</div>
	            </div>
	           
	          </div> 
	            <!--  상품템플릿 시작, iframe으로 변경 -->
	            <iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	        <aside>
		        <div id="sideBar">
						<ul>
							<li><img src="/img/새벽.png" alt="" /></li>
							<li><a href="/bbs_Notice/noticebbs.jsp">고객센터</a></li>
							<li><a href="/Member/MyPage.jsp">마이페이지</a></li>
							<li><a href="">이벤트</a></li>
						</ul>
				</div>
				<div id="topBtnArea">&uarr;</div>
			</aside>
	</div>
	<!-- div#wrap -->
  </body>
</html>