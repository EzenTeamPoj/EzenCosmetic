<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="bbsMgr" class="pack_BBS.BoardMgr" />

<%

int rtnCnt = bbsMgr.insertBoard(request);

if (rtnCnt == 1) {

	response.sendRedirect("/bbs_Notice/noticebbs.jsp");
} else {
	//
}
%>