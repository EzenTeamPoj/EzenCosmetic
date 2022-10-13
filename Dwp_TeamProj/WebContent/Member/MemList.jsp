<%@page import="pack_Member.MemberBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<jsp:useBean id="objMgr" class="pack_Member.MemberMgr" scope= "page"/>
<%
List<MemberBean> objList = objMgr.mtd_Select();
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>회원목록</title>
	  <link rel="stylesheet" href="/style/common_style.css">
	  <link rel="stylesheet" href="/style/indd.css">
	  <link rel="stylesheet" href="/style/MemList_style.css">
	  <link rel="shorcut icon" href="#">
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script src="/script/script_admin_Del.js"></script>
	</head>
  <body>
	  <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="MemListWrap">
	<table>
		<tbody>
			<tr>
			<th><input type="checkbox" id="chkAll" /></th>
			<th>번호</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>회원이름</th>
			<th>이메일</th>
			<th>휴대폰번호</th>
			<th>나이</th>
			<th>주소</th>
			<th>성별</th>
			<th>생일</th>
			<th>추천인</th>
			<th>가입시간</th>
			<th>개별관리</th>
			</tr>
			<%
			 for(int i = 0 ; i< objList.size(); i++){
			MemberBean objMB = objList.get(i);
			
/* 			String uZipcode = request.getParameter("uZipcode");
			String uAddr = request.getParameter("uAddr");
			String Addr = uZipcode + uAddr; */
			
			String gender ="남성";
			if(objMB.getuGender() == 2){
				gender ="여성";
			}else{
				gender ="선택안함";
			}
			%>
			<tr>
			<td><input type="checkbox" name="num"
			class="DelChk" value="<%=objMB.getNum()%>" form="memDelForm" /></td>
			<td><%= objMB.getNum()%></td>
			<td ><%= objMB.getuId()%></td>
			<td><%=objMB.getuPw() %></td>
			<td ><%= objMB.getuName()%></td>
			<td><%= objMB.getuEmail()%></td>
			<td><%= objMB.getuPhone()%></td>
			<td><%=objMB.getuAge()%></td>
			<td class="sizeCh"><%=objMB.getuAddr()%></td>
			<td><%=gender%></td>
			<td><%=objMB.getuBirth() %></td>
			<td><%=objMB.getRecoPerson() %></td>
			<td><%=objMB.getJoinTM() %></td>
			<td ><button class="btnDel"
			 value="<%=objMB.getNum() %>">
			 &times;</button></td>
			</tr>
		<%}%>
		</tbody>
			<tfoot>
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="4" style="text-align: right; padding-right: 10px">
							    <button id="multiDel" type="button" class="bottomBtn">선택항목 삭제</button>
								<button onclick="location.href='/index.jsp'" class="bottomBtn">
								메인으로
								</button>
							</td>
						</tr>
					</tfoot>
		
	</table>
	</div>
	<!--div#wrap-->
	
	<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0></iframe>
	
	<form id="memDelForm">
		<input type="hidden" name="multiFlag" value="m">
	</form>
  </body>
</html>