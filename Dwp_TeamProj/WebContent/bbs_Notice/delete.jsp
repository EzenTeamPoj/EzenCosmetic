<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="pack_BBS.BoardBean"%>


<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="DelMgr" class="pack_BBS.BoardMgr" scope="page" />

<%
String nowPage = request.getParameter("nowPage");
String reqNum = request.getParameter("num");
int numParam = Integer.parseInt(reqNum);
BoardBean bean = (BoardBean) session.getAttribute("bean");
int exeCnt = DelMgr.deleteBoard(numParam);
String url = "/bbs_Notice/noticebbs.jsp?nowPage=" + nowPage;
%>

<script>
	alert("삭제되었습니다!");
	location.href = "<%=url%>";
</script>