<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
String aId_Session = (String)session.getAttribute("aId_Session"); 
String uId_Session = (String)session.getAttribute("uId_Session");
%> 

<%@ page import="pack_Often.BoardBean" %>
<jsp:useBean id="bMgr" class="pack_Often.BoardMgr"  scope="page" />
<%
request.setCharacterEncoding("UTF-8");
int numParam = Integer.parseInt(request.getParameter("num"));

// 검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
// 검색어 수신 끝

// 현재 페이지 돌아가기 소스 시작
String nowPage = request.getParameter("nowPage");
// 현재 페이지 돌아가기 소스 끝

bMgr.upCount(numParam);    // 조회수 증가
BoardBean bean = bMgr.getBoard(numParam);   
//  List.jsp에서 클릭한 게시글의 매개변수로 전달된 글번호의 데이터 가져오기
     
int num =  bean.getNum();
String aId	=	bean.getaId();
String subject	= bean.getSubject();
String content	= bean.getContent();
String regTM	= bean.getRegTM();
int readCnt 	= bean.getReadCnt();
String fileName	= bean.getFileName();
double fileSize 	= bean.getFileSize();
String fUnit = "Bytes";
if(fileSize > 1024) {
	fileSize /= 1024;	
	fUnit = "KBytes";
} 

session.setAttribute("bean", bean);
%>   	

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>글내용 보기</title>
	<link rel="stylesheet" href="/style/Often.css">
	<link rel="stylesheet" href="/style/style_BBS.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="/script/script_Often.js"></script>
</head>

<body>
<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
    <div id="wrap">
    	

    		<div id="contents" class="bbsRead">

				<!--  게시글 상세보기 페이지 내용 출력 시작 -->
				<h2><%=subject %></h2>
				
				<table id="readTbl">
					<tbody id="readTblBody">
						<tr class="listName">
							<td class="line">작성자</td>  <!-- td.req 필수입력 -->
							<td class="line"><%=aId %></td>
							<td class="line">등록일</td>  <!-- td.req 필수입력 -->
							<td class="line"><%=regTM %></td>
						</tr>
						<tr>
							<td class="line">첨부파일</td> <!-- td.req 필수입력 -->
							<td colspan="3" class="line">
								<input type="hidden" name="fileName" value="<%=fileName%>" 
											id="hiddenFname">
							<% if (fileName != null && !fileName.equals("")) { %>						
								<span id="downloadFile"><%=fileName %></span>							
								(<span><%=(int)fileSize + " " + fUnit%></span>)
							<% } else { %>
								등록된 파일이 없습니다.
							<% } %>
							</td>
						</tr>
						<tr>
							<td colspan="4" id="readContentTd"><pre><%=content %></pre></td>
						</tr>					
					</tbody>
					 
					<tfoot id="readTblFoot">	
						<tr>
							<td colspan="4" id="footTopSpace"></td>							
						</tr>			     
						<tr>
							<td colspan="4" id="articleInfoTd">
								<span><%="조회수 : " + readCnt %></span>					
							</td>							
						</tr>
						<tr>
							<td colspan="4" id="hrTd"><hr></td>							
						</tr>
						<tr>
							<%
							String listBtnLabel = "";
							if(keyWord.equals("null") || keyWord.equals("")) {
								listBtnLabel = "리스트";
							} else {
								listBtnLabel = "검색목록";
							}
							%>
						
							<td colspan="4" id="btnAreaTd" class="read">
								<button type="button" id="listBtn"><%=listBtnLabel %></button>
								<% 
									// out.print("uId_Session : "+ uId_Session + "<br>" + "uId : "+ uId);
								if(aId_Session != null){	
								if (aId_Session.equals(aId))  { 
								%>
								<button type="button" id="modBtn">수 정</button>
								<button type="button" id="delBtn">삭 제</button>
								<% } %>
								<% } %>
							</td>
						</tr>
					</tfoot>
					 
				</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
				<!-- 검색어전송 시작 -->
				<input type="hidden" id="pKeyField" value="<%=keyField%>">
				<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
				<!-- 검색어전송 끝 -->
			  
				<!--  게시글 상세보기 페이지 내용 출력 끝 -->
				

    		</div>
    		<!-- 실제 작업 영역 끝 -->  
         <iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0></iframe>
    </div>
    <!-- div#wrap -->

</body>

</html>