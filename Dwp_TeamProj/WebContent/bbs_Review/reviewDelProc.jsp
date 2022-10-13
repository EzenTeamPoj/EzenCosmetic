<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="pack_ReviewBoard.ReviewBoardBean" %>
<jsp:useBean id="objBoard" class="pack_ReviewBoard.ReviewBoardMgr"  scope="page" />

<%
String nowPage = request.getParameter("nowPage");

String prodNumParam = request.getParameter("prodNum");
int prodNum = Integer.parseInt(prodNumParam); 
String totalReviewNumParam = request.getParameter("totalReviewNum");
int totalReviewNum = Integer.parseInt(totalReviewNumParam);

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

int exeCnt = objBoard.deleteBoard(totalReviewNum);
if(exeCnt == 1) {
String url = "/bbs_Review/reviewList.jsp?prodNum="+prodNum+"&nowPage="+nowPage;
		 url += "&keyField="+keyField;
		 url += "&keyWord="+keyWord;
%>	
<script>
	alert("삭제되었습니다!");
	location.href = "<%=url%>";
</script>
<% } %>