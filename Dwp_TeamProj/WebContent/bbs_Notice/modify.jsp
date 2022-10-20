<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="pack_BBS.*"%>


<jsp:useBean id="bMgr" class="pack_BBS.BoardMgr" />

<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("num"));
BoardBean bean = bMgr.getBoard(numParam);
int num = Integer.parseInt(request.getParameter("num"));
//out.print("num :" +num + "<br>");
String nowPage = request.getParameter("nowPage");
//out.print("nowPage :" +nowPage+ "<br>");
String asubject = bean.getAsubject();
String aName = bean.getaName();
String acontent = bean.getAcontent();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 수정</title>

<link rel="stylesheet" href="/style/style_BBS.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Notice.js"></script>
</head>

<body>
	<div id="wrap">




		<main id="main" class="dFlex">




			<!-- 실제 작업 영역 시작 -->
			<div id="contents" class="mod">


				<!--  뷰페이지 내용 출력 시작 -->

				<form name="modifyNotProcFrm" action="/bbs_Notice/modifyProc.jsp"
					method="get" id="modifyNotProcFrm">

					<h2><%=asubject%></h2>

					<table id="modTbl">
						<tbody id="modTblBody">
							<tr>
								<td class="req">작성자</td>
								<td><%=aName%></td>
							</tr>
							<tr>
								<td class="req">제목</td>
								<td><input type="text" name="asubject"
									value="<%=asubject%>" size="50" id="asubject"></td>
							</tr>
							<tr>
								<td style="vertical-align: top;">내용</td>
								<td><textarea name="acontent" id="txtArea" cols="89"
										wrap="hard"><%=acontent%></textarea></td>
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
									<button type="button" id="modNotBtn" class="modProcBtn">수정하기</button>
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