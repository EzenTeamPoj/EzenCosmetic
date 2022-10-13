<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush="true"%>
    <%@ page import="pack_BBS.BoardBean"%>
<jsp:useBean id="lMgr" class="pack_BBS.BoardMgr" scope="page" />
    <%
    request.setCharacterEncoding("UTF-8");
    
String uId_Session = (String)session.getAttribute("uId_Session");

String aId_Session = (String)session.getAttribute("aId_Session");

String numParam = request.getParameter("num");
 int num = Integer.parseInt(numParam);
String nowPageParam = request.getParameter("nowPage");
 int nowPage= Integer.parseInt(nowPageParam);
    
  
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="//style/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/script/script_Inquire.js"></script>
</head>
<body>
    <div id="wrap">
	<h4>비밀번호를 입력해주세요</h4>

<form>
		<input type="text" name="bbsPw" id="bbsPw"
										 size="20" maxlength="30">

		<button type="button" id="chkPwBtn">입력</button>
		<input type="hidden" name="num" id="num" value="<%=num%>">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>">

	</form>
    </div>
    <!-- div#wrap  -->
</body>
</html>
