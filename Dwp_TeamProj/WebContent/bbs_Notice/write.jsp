<%@page import="java.util.Vector"%>
<%@page import="pack_BBS.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>

	<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session"); 
String aId_Session = (String)session.getAttribute("aId_Session"); 
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="/style/style_BBS.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Notice.js"></script>
</head>
<body>
	<div id="wrap">

		<form action="/bbs_Notice/writeProc.jsp" method="post"
			enctype="multipart/form-data">

<!-- 안녕하세요 -->

			<main id="main">
			
			<div class="bbsWrite">
				<table>
					<caption>공지사항</caption>
					<tbody>
						<tr>

							<td>이름<%=aId_Session %><input type="hidden" name="aName" id="aName" value="<%=aId_Session%>"/>

							</td>
						</tr>
						<tr>
							<td>제목 <input type="text" name="asubject" id="asubject">
							</td>
						</tr>



						<tr>
							<td>사진첨부<input type="file" name="aupFileName"></td>

						</tr>

					</tbody>

				</table>
				<hr>
				<div id="option">

					<select id="">
						<option value="">스타일</option>
					</select> <select name="" id="">
						<option value="문단">문단</option>
					</select> <select name="" id="">
						<option value="글꼴">글꼴</option>
					</select> <select name="" id="">
						<option value="크기">크기</option>
					</select>
				</div>
				<textarea name="acontent" id="acontent" rows="10"></textarea>
				<hr>

			</main>
			<aside id="aside" class="dFlex">

				<div id="submitBtn">
					<button type="submit" id="NoticeBtn">작성완료</button>
					<button type="reset" id="reset">취소</button>
				</div>
			</aside>

			</div>

			<input type="hidden" name="ip" id="ip"
				value="<%=request.getRemoteAddr()%>" />


		</form>

	</div>
	<!-- div#wrap  -->
</body>
</html>