<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<jsp:useBean id="aMgr" class="pack_Admin.AdminMgr" />
<% 
String aId = request.getParameter("aId");
String aPw = request.getParameter("aPw");
request.setCharacterEncoding("UTF-8"); 
boolean loginRes =aMgr.Administratorlogin(aId, aPw);

%>

<script>
<%
if (loginRes) {
	session.setAttribute("aId_Session", aId);
%>	
	location.href="/index.jsp";
<%
} else {
%>	
	alert("아이디 또는 비밀번호를 확인해주세요.");
	location.href="/Admin/index.jsp";
<%
}
%>
</script>