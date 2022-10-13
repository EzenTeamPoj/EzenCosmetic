<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pack_BBS.*"%>
<%@page import="pack_Member.MemberBean"%>

<jsp:useBean id="lMgr" class="pack_BBS.BoardMgr" scope="page" />
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("num"));
BoardBean bean = lMgr.getInqBoard(numParam);
//out.print("numParam :" +numParam + "<br>");
int num=bean.getNum();
String nowPage = request.getParameter("nowPage");
String subject = bean.getSubject();
String uName = bean.getuName();
String content = bean.getContent();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정</title>

<link rel="stylesheet" href="/style/style_BBS_Inq.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Inquire.js"></script>
</head>

<body>
	<div id="wrap">



		<main id="main" class="dFlex">




			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="mod">


				<!--  뷰페이지 내용 출력 시작 -->

				<form name="modifyInqProcFrm" action="/bbs_Inquire/modifyProc.jsp" method="get"
					id="modifyInqProcFrm">

					<h2><%=subject%></h2>

					<table id="modTbl">
						<tbody id="modTblBody">
							<tr>
								<td class="req">작성자</td>
								<td><%=uName%></td>
							</tr>
							<tr>
								<td class="req">제목</td>
								<td><input type="text" name="subject" value="<%=subject%>"
									size="50" id="subject"></td>
							</tr>
							<tr>
								<td style="vertical-align: top;">내용</td>
								<td><textarea name="content" id="txtArea" cols="89"
										wrap="hard"><%=content%></textarea></td>
							</tr>
						</tbody>

						<tfoot>
							<tr>
								<td colspan="2" id="footTopSpace"></td>
							</tr>
							<tr>
								<td colspan="2" id="hrTd"><hr></td>
							</tr>
							<tr>
								<td colspan="2" id="btnAreaTd" class="update">
									<button type="button" id="modFinBtn" class="modProcBtn">수정하기</button>
									<button type="button" id="backBtn">뒤 로</button>
								</td>
							</tr>
						</tfoot>

					</table>
					<input type="hidden" name="nowPage" value="<%=nowPage%>"
						id="nowPage"> <input type="hidden" name="num"
						value="<%=num%>" id="num">



				</form>
				<!--  뷰페이지 내용 출력 끝 -->

			</div>
			<!-- 실제 작업 영역 끝 -->

		</main>
		<!--  main#main  -->


	</div>
	<!-- div#wrap -->

</body>

</html>