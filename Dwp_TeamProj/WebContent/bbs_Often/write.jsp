<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:useBean id="mMgr" class="pack_Admin.AdminMgr" scope="page" />
<%
String uId_Session = (String)session.getAttribute("uId_Session");
String aId_Session = (String)session.getAttribute("aId_Session"); 
String aName = mMgr.getaIdmtd(aId_Session);

%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글쓰기</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/script/script_Often.js"></script>
	 <link rel="stylesheet" href="/style/Often.css">
</head>

<body>
  <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	    	<!-- 실제 작업 영역 시작 -->
	    	<div id="wrap">
    		<div id="contents" class="bbsWrite">

				<h2>글쓰기</h2>
				
				<form name="writeFrm" enctype="multipart/form-data" 
						  method="post" id="writeFrm">
				
					<table>
						<tbody>
            				<tr>
								<td class="req">이름</td>  <!-- td.req 필수입력 -->
								<td class="aName">
									<%=aName%>
									<input type="hidden" name="aName" value="<%=aName%>">
								   <input type="hidden" name="aId" value="<%=aId_Session%>">
								</td>
								<td>
								<select name="qnaType" id="qnaType">
									<option value="">문의유형</option>
									<option value="change">취소/반품/교환</option>
									<option value="pay">주문/결제</option>
									<option value="event">이벤트</option>
									<option value="something">기타</option>
							</select>
							</td>
							</tr> 
							<tr>
								<td class="req">제목</td> <!-- td.req 필수입력 -->
								<td>
									<input type="text" name="subject"
									maxlength="50" id="subject">
								</td>
							</tr>
							<tr>
								<td class="contentTD">내용</td>
								<td> 
									<textarea name="content" id="content" cols="60" wrap="hard"></textarea>
								</td>
							</tr>
							<tr>
								<td>파일첨부</td>
								<td>
									<span class="spanFile">
										<input type="file" name="fileName" id="fileName">
									</span>	
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2"><hr>	</td>							
							</tr>
							<tr>
								<td colspan="2">
									<button type="button" id="regBtn">등록</button>
									<button type="reset">다시쓰기</button>
									<button type="button" onclick="location.href='/bbs_Often/list.jsp'">리스트</button>
								</td>
							</tr>
						</tfoot>
					</table>				
				</form>
    		</div>
    		<!-- div#contents -->
    		</div>
    		<!-- div#wrap -->
    		<!-- 실제 작업 영역 끝 -->
    		    	
</body>
 <iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0></iframe>

</html>