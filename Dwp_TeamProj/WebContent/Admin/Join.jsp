<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/style/common_style.css">
	<link rel="stylesheet" href="/style/indd.css">
	<link rel = "stylesheet" href="/style/ajoin_style.css">
	<link rel = "shortcyt icon" href="#">
	<script src ="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src ="/script/script_Join&LoginA.js"></script>
</head>
<body>
	<div id="joinWrap">
    <form action="/Admin/Join_Proc.jsp">
	     <table>
	     <tbody>
	     <tr><th >아이디</th>
	 <td>
	 <input type="text"
	 name="aId" id="aId" class="req">
	 </td>
	     </tr>
	     <tr>
	     <th>비밀번호</th>
	     <td><input type="password"
	     name="aPw" id="aPw" class="req"></td>
	     </tr>
	     <tr>
	     <th>비밀번호 확인</th>
	     <td>
	     <input type="password"
	     id ="aPwdpChk"
	     class="req">
	     <span id="pwChk"></span>
	     </td>
	     </tr>
	     <tr>
	     <th class="req">이름</th>
	     <td><input type="text"
	     name="aName" id="aName"
	     class="req"></td>
	     </tr>
	     <tr>
	     <th class="req">이메일</th>
	     <td>
	     <input type="text" id="aEmail1" class="req">
	     <span>@</span>
	     <input type="text" id="aEmail2" class="req">
 	     <select id="valSel">
	     	<option value="">직접입력</option>
	     	<option>naver.com</option>
	     	<option>daum.net</option>
	     	<option>google.co.kr</option>
	     </select>
	     <input type="hidden" id="aEmail" name="aEmail">
	     
	     </td>
	     </tr>
	     <tr>
	     <th class="req">휴대폰</th>
	     <td><input type="text" placeholder="숫자만 입력해주세요"
	     name="aPhone" id="aPhone"
	     class="req"></td>
	     </tr>
	      <tr>
	     <td><button id="joinBtn">가입하기</button></td>
	     </tr>
	     </tbody>
	     </table>
	     </form>
	   </div>
	<!--div#wrap-->
  </body>
</html>