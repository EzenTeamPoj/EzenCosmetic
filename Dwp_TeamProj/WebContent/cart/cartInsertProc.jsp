<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="objMgr" class="pack_ProdBoard.ProdBoardMgr" />
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="objBean" class="pack_ProdBoard.CartBean" />
<jsp:setProperty name="objBean" property="*" />

<% 
int rntCnt =objMgr.insertCart(objBean);%>
<script>
<% if (rntCnt == 1) { %>
	alert("장바구니에 추가됐습니다.");
<% } else { %>
	alert("장바구니 추가에 오류가 발생했습니다.");
<% } %>
</script>