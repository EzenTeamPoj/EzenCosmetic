<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="pack_ReviewBoard.ReviewBoardBean" %>
<jsp:useBean id="objBoard" class="pack_ReviewBoard.ReviewBoardMgr"  scope="page" />

<%
String presserId = (String)session.getAttribute("uId_Session");
String nowPage = request.getParameter("nowPage");

String prodNumParam = request.getParameter("prodNum");
int prodNum = Integer.parseInt(prodNumParam); 
String totalReviewNumParam = request.getParameter("totalReviewNum");
int totalReviewNum = Integer.parseInt(totalReviewNumParam);

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

int exeCnt = objBoard.recommendBoard(totalReviewNum, presserId);
String url = "/bbs_Review/reviewList.jsp?prodNum="+prodNum+"&nowPage="+nowPage;
		 url += "&keyField="+keyField;
		 url += "&keyWord="+keyWord;
if(exeCnt == 1) {
%>	
<script>
	alert("추천하셨습니다!");
	location.href = "<%=url%>";
</script>
<% }  else if (exeCnt == -1) { %>	
<script>
	alert("추천을 이미 하셨습니다");
	location.href = "<%=url%>";
</script>
<% } else { %>
	alert("추천에 오류가 발생했습니다.");
	location.href = "<%=url%>";
<%  } %>