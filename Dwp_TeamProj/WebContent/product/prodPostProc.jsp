<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
	objBoard.insertBoard(request);
	response.sendRedirect("/product/prodList.jsp");
%>