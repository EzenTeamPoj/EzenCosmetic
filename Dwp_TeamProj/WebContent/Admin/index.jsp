<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/style/common_style.css">
	<link rel="stylesheet" href="/style/main_style.css">
	<link rel="stylesheet" href="/style/indd.css">
	<link rel = "stylesheet" href="/style/logn_style.css">
	<link rel = "shortcyt icon" href="#">
	<script src ="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src ="/script/script_Member.js"></script>
</head>
<body>
<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="adminWrap">
     <form action="/Admin/Login_Proc.jsp">
     <table id="loginTBL">
                    <tbody>
                        <tr>
                            <td>
                                 <input type="text" name="aId" id="aId"
                                 placeholder="아이디" />
                            </td>
                            <td rowspan="2" id="tdLogInBtn">
                                <button>LOG IN</button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="password" name="aPw" id="aPw"
                                placeholder="비밀번호" />
                            </td>
                        </tr>
                        <tr>
                        <td><button type="button" onclick="location.href='/Admin/Join.jsp'"
                        id=ajoinBtn>회원가입</button></td>
                        </tr>
                    </tbody>
                </table>
     </form>
     
     
     
     
     <iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	<aside>
		        <div id="sideBar">
						<ul>
							<li><img src="/img/새벽.png" alt="" /></li>
							<li><a href="/bbs_Notice/ServiceMain.jsp">고객센터</a></li>
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