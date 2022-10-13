<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ProdBoard.ProdBoardMgr"  scope="page" />
    
<%
	request.setCharacterEncoding("UTF-8");
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String [] pNum =request.getParameterValues("pNum");
	
	int rtnCnt = objBoard.insertCartMulti(uId_Session, pNum);
	
	if(pNum.length==rtnCnt) { %>
		<script>
			alert("장바구니에 추가되었습니다.");
			location.href="/cart/cartList.jsp";
		</script>
<% 
	} else {   %>
		<script>
			alert("장바구니 추가에 오류가 발생했습니다.");
			location.href="/wishlist/wishlist.jsp";
		</script>
<% 		
		
	}
%>
