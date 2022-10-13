<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pack_Member.*"%>
<%@ page import="pack_BBS.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="inqMgr" class="pack_BBS.BoardMgr" />

<%
int rtnCnt = inqMgr.inquireBoard(request);
if (rtnCnt == 1) {
	response.sendRedirect("/bbs_Inquire/list.jsp");
} else {
	//
}
%>