<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="objMgr" class="pack_ProdBoard.ProdBoardMgr" />
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="objBean" class="pack_ProdBoard.WishlistBean" />
<jsp:setProperty name="objBean" property="*" />

<% 
int rntCnt =objMgr.insertWishlist(objBean);%>
<script>
<% if (rntCnt == 1) { %>
	alert("위시리스트에 추가됐습니다.");
<% } else if(rntCnt != 1) { %>
	alert("해당 상품은 위시리스트에 이미 존재합니다.");
<% } else { %>
	alert("위시리스트 추가에 오류가 발생했습니다.");
<% } %>
</script>