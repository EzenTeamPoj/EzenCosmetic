<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr"  scope="page" />
    
<%
	request.setCharacterEncoding("UTF-8");
	String [] num =request.getParameterValues("num");
	
	int rtnCnt = objBoard.deleteWishMulti(num);
	
	if(num.length==rtnCnt) { %>
		alert("삭제되었습니다.");
<% 
		response.sendRedirect("/wishlist/wishlist.jsp"); 
	} else {   %>
		alert("장바구니 삭제에 문제가 발생했습니다.");
<% 		response.sendRedirect("/wishlist/wishlist.jsp");
		
	}
%>
