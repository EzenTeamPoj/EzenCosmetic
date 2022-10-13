<%@page import="pack_ReviewBoard.ReviewBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String aId_Session = (String)session.getAttribute("aId_Session");
	
	int prodNum = Integer.parseInt(request.getParameter("prodNum"));
	int totalReviewNum = Integer.parseInt(request.getParameter("totalReviewNum"));
	
	
	String nowPage = request.getParameter("nowPage");

	//검색어 수신 시작
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	//검색어 수신 끝
%>
	
	<jsp:useBean id="objMgr" class="pack_ReviewBoard.ReviewBoardMgr" />
<%
	ReviewBoardBean objBean = objMgr.modifyBoard(totalReviewNum);
	String regId = objBean.getRegId();
	String regName = objBean.getRegName();
	String subject = objBean.getSubject();
	String content = objBean.getContent();
	String sysFileName = objBean.getSysFileName();
%>    

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>수정하기</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/review_style.css">
	<script src="/source/jquery-3.6.0.min.js"></script>
	<script src="/script/script_Review.js"></script>
</head>

<body>
    <div id="wrap">
    	

	    	<form 
		action="/bbs_Review/reviewModProc.jsp"
		method="get">
						  
			<main id="main">
				<div class="bbsWrite">
					<h2>후기 수정</h2>
					<table class="bbsWrite">
						<tbody>
							<tr>
								<td>이름</td>
								<td>
									<%=regName %>				
								</td>
								
							</tr>
		
							<tr>
								<td class="req">제목</td>
								<td>
									<input type="text" name="subject" id="subject" value="<%=subject%>">
								</td>
							</tr>
								
	<!-- 					<tr>
								<td>사진첨부</td>
								<td><input type="file" name="upFileName"></td>
							</tr> -->
							<tr>
								<td class="contentTD">내용</td>
								<td>
									<textarea name="content" id="content" rows="10"><%=content %></textarea>
								</td>
							</tr>
						</tbody>
	
					</table>
				</div>

					
				
			<hr>

			</main>
			<aside id="aside">
				<div id="submitBtn">
					<button type="submit" id="regBtn">작성완료</button>
					<button type="reset" id="reset">취소</button>
				</div>
			</aside>

			<input type="hidden" name ="prodNum" value="<%=prodNum%>">
			<input type="hidden" name = "totalReviewNum" value="<%=totalReviewNum %>">
			
			<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
			<!-- 검색어전송 시작 -->
			<input type="hidden" name="keyField" id="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" id="keyWord" value="<%=keyWord%>">
			<!-- 검색어전송 끝 -->
			

		</form>
    		    	
    
        
    </div>
    <!-- div#wrap -->

</body>

</html>