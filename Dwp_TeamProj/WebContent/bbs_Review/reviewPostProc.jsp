<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="objBoard" class="pack_ReviewBoard.ReviewBoardMgr"/>

<%


int rtnCnt = objBoard.insertBoard(request);

int prodNum = Integer.parseInt(request.getParameter("prodNum"));

if(rtnCnt==1){
	response.sendRedirect("/bbs_Review/reviewList.jsp?prodNum="+prodNum); 

}
%>