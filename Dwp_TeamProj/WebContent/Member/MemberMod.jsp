<%@page import="pack_Member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<%
String uId_Session = (String)session.getAttribute("uId_Session");
%>    
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />

<%
MemberBean objMB  = mMgr.modifyMember(uId_Session);
String uEmail = objMB.getuEmail();
int idx = uEmail.indexOf("@");

String uEmail1 = uEmail.substring(0, idx);
String uEmail2 = uEmail.substring(idx+1);

String Addr = objMB.getuAddr();
String postNum = Addr.substring(1,6);
String remainAddr = Addr.substring(7);
%>    

  
<!DOCTYPE html>
<html lang="ko">
	<head>
	  <meta charset="UTF-8">
	  <title>Insert title here</title>
	  <link rel="stylesheet" href="/style/common_style.css">
	  <link rel="stylesheet" href="/style/memberMod.css">
	  <link rel="shorcut icon" href="#">
	  
	  <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	  <script src ="/script/ApiScript.js"></script>
	  <script src="/script/script_Member_Mod.js"></script>
	</head>
   <body>
   	  <header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  	</header>
	<div id="modWrap" class="dFlex">
	<div id="sideMenu">
          <ul class="List">
	     <li><a href="/cart/cartList.jsp" id="cart">장바구니</a></li>
	     <li><a href="/wishlist/wishlist.jsp" id="wish">찜 제품</a></li>
	     <li><a href="">주문현황</a></li>
	     <li><a href="/bbs_Inquire/list.jsp" id="inq">1대1문의</a></li>  
	       <hr>
	      <li><a href="/Member/MemberMod.jsp" id="mod">회원정보수정</a></li>
	      <li><a href="/Member/MemberDel.jsp" id="del">회원탈퇴</a></li>
	   </ul>
    	</div>
	   <div id="container">
	<form action="/Member/MemberModProc.jsp" id="ModFrm">
	     <table>
	     <tbody>
	     <tr><th class="req">아이디</th>
	 <td>
	 <%= objMB.getuId() %>
	 <input type="hidden" name="uId" value="<%= uId_Session %>">
	 </td>
	     </tr>
	     <tr>
	     <th class="req">비밀번호</th>
	     <td><input type="password" name="uPw" id="uPw" value="<%=objMB.getuPw()%>"></td>
	     </tr>
	     <tr>
	     <th>비빌번호 확인</th>
	     <td>
	     <input type="password" value="<%=objMB.getuPw()%>">
	     <span id="pwChk"></span>
	     </td>
	     </tr>
	     <tr>
	     <th class="req">이름</th>
	     <td><%=objMB.getuName()%></td>
	     </tr>
	     <tr>
	     <th class="req">이메일</th>
	     <td>
	     <input type="text" id="uEmail1" value = "<%=uEmail1%>" >
	     <span>@</span>
	     <input type="text" id="uEmail2" value = "<%=uEmail2%>">
 	     <select id="valSel">
	     	<option value="">직접입력</option>
	     	<option>naver.com</option>
	     	<option>daum.net</option>
	     	<option>google.co.kr</option>
	     </select>
	     <input type="hidden" id="uEmail" name="uEmail">
	     </td>
	     </tr>
	     <tr>
	     <th class="req">휴대폰</th>
	     <td><input type="text" name="uPhone" id="uPhone" value="<%=objMB.getuPhone() %>"></td>
	     </tr>
	     <tr>
	     <th class="req">우편번호</th>
	     <td>
	     <input type="text" id="postcode" placeholder="우편번호" class="req" value="<%=postNum%>">
         <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" ><br>
	     </td>
	     </tr>
	     <tr>
	     <th class="req">주소</th>
	     <td>
         <input type="text" id="address" placeholder="주소" class="refList" value="<%= remainAddr%>"><br>
         </td>
         </tr>
         <tr>
         <th class="req">상세주소</th>
         <td>
         <input type="text" id="detailAddress" placeholder="상세주소"
         class="refList">
         </td>
         </tr>
         <tr>
         <th class="req">참고항목</th>
         <td>
         <input type="text" id="extraAddress" placeholder="참고항목"
         class="refList">
         <input type="hidden" name="uAddr" id="uAddr" />
         </td>
         </tr>
	     <tr>
	     <th class="req">성별</th>
	     <td>
	     <%
	     int gender = objMB.getuGender();
	     String chkMale = "";
	     String chkFemale = "";
	     String chkNone ="";
	     if(gender==1){
	    	chkMale = "checked"; 
	     }else if(gender ==2){
	    	 chkFemale = "checked";
	     }else{
	        chkNone = "checked";
	     }
	     %>
	     <label>
	    <input type="radio" name="uGender" value="1" 
	     <%=chkMale%>> <span class="radioSel">남자</span>
	     </label>
	     <label>   
	     <input type="radio" name="uGender" value="2" 
	     <%=chkFemale%>><span class="radioSel">여자</span>
	     </label>
	     <label>   
	     <input type="radio" name="uGender" value="3" 
	     <%=chkNone%>><span class="radioSel">선택안함</span>
	      </label>
	     </td>
	     </tr>
	     <tr>
	     <th>생년월일</th>
	     <td><input type="text" placeholder="YYYY / MM / DD"
	      name= "uBirth" value ="<%=objMB.getuBirth()%>"></td>
	     </tr>    
	     </tbody>
	     </table>
	     <div id="btnArea">
	     <button id="modBtn">수정하기</button>
	     <button type="reset">다시쓰기</button>
	     </div>
	     </form>
	   </div>
	   <!-- div#container 끝-->
	</div>
	<!--div#wrap 끝 -->
	
	<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	
  </body>
</html>