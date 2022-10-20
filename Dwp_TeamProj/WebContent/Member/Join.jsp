<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" autoFlush="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>JoinPage</title>
<link rel="stylesheet" href="/style/common_style.css">
<link rel="stylesheet" href="/style/join_style.css">
<link rel="shorcut icon" href="#">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/script/script_Join&Login.js"></script>
<script src="/script/script_Common.js"></script>
</head>
<body>
	<header>
		<!--  헤더템플릿 시작, iframe으로 변경 -->
		<iframe src="/indd/header.jsp" scrolling="no" width="100%"
			frameborder=0 id="headerIfm"></iframe>
		<!--  헤더템플릿 끝 -->
	</header>
	<div id="joinWrap">
		<div id="container">
			<div id="title">회원가입</div>
			<div id="req" class="req">필수입력사항</div>
			<form  id="joinFrm">
				<table>
					<tbody>
						<tr>
							<th class="req">아이디</th>
							<td><input type="text" placeholder="아이디를 입력해주세요" name="uId"
								id="uId" class="reqs"> <span>
								<button type="button" id="dpChk">중복확인</button></span> <!-- dpChk: duplicateChek -->
							     <input type="hidden" id="id_Chek" value="" />
							</td>
						</tr>
						<tr>
							<th class="req">비밀번호</th>
							<td><input type="password" placeholder="비밀번호를 입력해주세요"
								name="uPw" id="uPw" class="reqs"></td>
						</tr>
						<tr>
							<th class="req">비빌번호 확인</th>
							<td><input type="password" id="uPwdpChk" class="reqs">
								<span id="pwChk"></span></td>
						</tr>
						<tr>
							<th class="req">이름</th>
							<td><input type="text" placeholder="이름을 입력해주세요" name="uName"
								id="uName" class="reqs"></td>
						</tr>
						<tr>
							<th class="req">이메일</th>
							<td><input type="text" id="uEmail1" maxlength="10"
								class="reqs"> <span>@</span> <input type="text"
								id="uEmail2" maxlength="15" class="reqs"> <select
								id="valSel">
									<option value="">직접입력</option>
									<option>naver.com</option>
									<option>daum.net</option>
									<option>google.co.kr</option>
							</select> <input type="hidden" id="uEmail" name="uEmail"></td>
						</tr>
						<tr>
							<th class="req">휴대폰</th>
							<td><input type="text" placeholder="숫자만 입력해주세요"
								name="uPhone" id="uPhone" class="reqs"></td>
						</tr>
						<tr>
							<th class="req">우편번호</th>
							<td><input type="text" id="postcode" placeholder="우편번호"
								class="reqs"> <input type="button"
								onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							</td>
						</tr>
						<tr>
							<th class="req">주소</th>
							<td><input type="text" id="address" placeholder="주소"
								class="reqs refList"><br></td>
						</tr>
						<tr>
							<td colspan="2"><input type="hidden" name="uAddr" id="uAddr" />
							</td>
						</tr>
						<tr>
							<th class="req">성별</th>
							<td><label> <input type="radio" name="uGender"
									value="1"> 남자
							</label> <label> <input type="radio" name="uGender" value="2">
									여자
							</label> <label><input type="radio" name="uGender" value="3">
									선택안함</label></td>
						</tr>
						<tr>
							<th class="req">생년월일</th>
							<td>
								<div class="info" id="birth">
									<select class="box" id="birth-year">
										<option selected value="">출생 연도</option>
									</select> <select class="box" id="birth-month">
										<option selected value="">월</option>
									</select> <select class="box" id="birth-day">
										<option selected value="">일</option>
									</select>
								</div> <input type="hidden" name="uBirth" id="uBirth">
								 <input type="hidden" name="uAge" id="uAge">
							</td>
						</tr>
						<tr>
							<th>추천인 아이디</th>
							<td><label> <input type="text" name="recoPerson"
									class="reqs">
							</label></td>
						</tr>
						<tr>
							<th>이용약관</th>
							<td>

								<div class="joinAgree">

									<div id="chkAllArea">
										<label for="chkAll"> <input type="checkbox"
											id="chkAll">전체동의합니다.
										</label>
									</div>
									<!-- div#chkAll 끝 -->

									<div class="licenseArea">

										<div class="termArea">
											<label> <input type="checkbox" class="useAgree">이용약관
												동의<span>(필수)</span>
											</label>
										</div>
										<div class="termArea">
											<label> <input type="checkbox" class="useAgree">개인정보
												수집 · 이용동의
											</label><span>(필수)</span>
										</div>

										<div class="termArea">
											<label> <input type="checkbox" class="useAgree"
												id="sub_chkAll"> 무료배송, 할인쿠폰 등 혜택/정보 수신 동의
											</label><span>(선택)</span>
										</div>

										<div class="termArea">
											<label> <input type="checkbox"
												class="useAgree socialAgree">SMS
											</label> <label> <input type="checkbox"
												class="useAgree socialAgree">이메일
											</label>
										</div>

										<div class="termArea">
											<label> <input type="checkbox" class="useAgree">본인은
												만14세이상입니다<span>(필수)</span>
											</label>
										</div>

									</div>
									<!-- div#licenseArea -->
								</div> <!-- div#joinAgree 끝 -->
							</td>
						</tr>
					</tbody>
				</table>
				<span><button type="button" id="joinBtn">가입하기</button> </span>
			</form>
		</div>
		<!-- div#container 끝-->
	</div>
	<!--div#joinWrap 끝 -->
	<iframe src="/indd/footer.jsp" scrolling="no" width="100%"
		frameborder=0></iframe>
</body>
</html>