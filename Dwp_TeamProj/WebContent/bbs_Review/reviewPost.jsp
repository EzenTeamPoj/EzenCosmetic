<%@page import="pack_Member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String aId_Session = (String)session.getAttribute("aId_Session");
	
	int prodNum = Integer.parseInt(request.getParameter("prodNum"));
%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<%
	String regId ="";
	String regName="";
	if (uId_Session != null) {
		regId=uId_Session;
		MemberBean objMB  = mMgr.modifyMember(uId_Session);
		regName = objMB.getuName();
	} else if (aId_Session != null) {
		regId=aId_Session;
		regName="판매자";
	}

%>    

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글쓰기</title>
	<link rel="stylesheet" href="/style/style_Common.css">
	<link rel="stylesheet" href="/style/review_style.css">
	<script src="/source/jquery-3.6.0.min.js"></script>
	<script src="/script/script_Review.js"></script>
</head>

<body>
    <div id="wrap">
    	
		
	    	<form 
		action="/bbs_Review/reviewPostProc.jsp?prodNum=<%=prodNum %>"
		method="post" enctype="multipart/form-data"
			>
						  
			<main id="main">
				<div class="bbsWrite">
					<h2>후기 작성</h2>
					<table class="bbsWrite">
						<tbody>
							<tr>
								<td>이름</td>
								<td>
									<%=regName %>
									<input type="hidden" name="regId" value="<%=regId%>">
									<input type="hidden" name="regName" value="<%=regName %>">					
								</td>
								
							</tr>
		
							<tr>
								<td class="req">제목</td>
								<td>
									<input type="text" name="subject" id="subject">
								</td>
							</tr>
								
							<tr>
								<td>사진첨부</td>
								<td>
									<span class="spanFile"><input type="file" name="upFileName"></span>
								</td>
							</tr>
							<tr>
								<td class="contentTD">내용</td>
								<td>
									<textarea name="content" id="content"></textarea>
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

			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name ="prodNum" value="<%=prodNum%>">
			

		</form>
    		    	
    
        
    </div>
    <!-- div#wrap -->

</body>

</html>