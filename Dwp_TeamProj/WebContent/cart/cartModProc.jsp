<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr"  scope="page" />
    
<%
	request.setCharacterEncoding("UTF-8");
	int num =Integer.parseInt(request.getParameter("num"));
	int pVolumn =Integer.parseInt(request.getParameter("pVolumn"));
	
	int rtnCnt = objBoard.updateCart(num, pVolumn);
	
	if(rtnCnt!=1) {    %>
		alert("장바구니 수정에 문제가 발생했습니다.");

		
<%	}	%>