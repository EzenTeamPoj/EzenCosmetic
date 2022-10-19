$(function () {
	//이메일 주소 병합 소스 만들기 시작 //
	let phEfck = /^(\d{3})-(\d{4})-(\d{4})$/;

	$("button#joinBtn").click(function () {
         
		let uId = $("#uId").val();
		let uPw = $("#uPw").val();
		let uPwdpChk = $("#uPwdpChk").val();
		// DB로 보낼 값 소스 만들기 //	
        let uEmail1 = $("input#uEmail1").val();
	    let uEmail2 = $("input#uEmail2").val();
		let uName = $("input#uName").val();
		let uEmail = uEmail1 + "@" + uEmail2;
		$("input#uEmail").val(uEmail);       // → 이메일 주소 병합
		
		let postcode = $("input#postcode").val();
	    let address = $("input#address").val();
		let uAddr = postcode + address;
		$("input#uAddr").val(uAddr);    // →  고객주소 병합
        let uPhone = $("input#uPhone").val();
		let uGender = $("input[name=uGender]:checked").length;


        let year = $("select#birth-year").val();
	    let month = $("select#birth-month").val();
	    let day = $("select#birth-day").val();

		const today = new Date();  // → 현재 날짜 출력
		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
		//  → 월이 10보다 작거나 또는 일이 10보다 작다면 
		//      월,일 앞에 0을 붙여 DB로 전송
		let uBirth = year + month + day;
		$("input#uBirth").val(uBirth);
		//  → 월이 10보다 크거나 또는 일이 10보다 크다면 
		//     일반적인 값을 DB로 전송
		let age = today.getFullYear() - year + 1;  // → 고객 나이를 계산
		// new Date를 이용한 현재 날짜 출력 
		// today변수에서 가져온 year - 고객생년 + 1 (한국나이)
		$("input#uAge").val(age);  // → 계산된 고객의 나이를 DB로 전송



		let phEfres = phEfck.test(uPw); // → uPw 유효성 검사
        

        if (uId == "") {
			alert("아이디가 입력하세요");
			$("#uId").focus();

		} else if (uPw.search(uId) > 0) {
			alert("비밀번호에 아이디가 포함되었습니다.");
			$("#uPw").focus();

		} else if (uPw ==""|| uPwdpChk =="") {
			alert("비밀번호를 입력해주세요");
		} else if (uPw != uPwdpChk) {
			alert("비밀번호가 일치하지 않습니다");
			$("#uPwdpChk").focus();

		}else if(uName ==""){
			alert("이름을 입력해주세요");
			$("#uName").focus();

		} else if (uEmail1 == "" || uEmail2 == "") {
			alert("이메일을 입력해주세요");
			$("#uEmail1").focus();

		} else if (year == "" || month== "" || day == "") {
			alert("생년월일을 선택해주세요");

		} else if (uPhone == "" || phEfres) {
			alert("전화번호를 다시 입력해주세요");
			$("#uPhone").focus();

		} else if (postcode == "" || address == "") {
			alert("주소를 입력해주세요");
			$("#address").focus();
        } else if (uGender < 1) {
			alert("성별을 선택해주세요");

		} else {
           $("form#joinFrm").attr("action","/Member/Join_Proc.jsp");
		}
	});


	$("#uPwdpChk").focusout(function () {
		let uPw = $("#uPw").val();
		let uPwdpChk = $("#uPwdpChk").val();

		if (uPw != "" || uPwdpChk != "") {
			if (uPw == uPwdpChk) {
				$("span#pwChk").html("비밀번호가 일치합니다");
				$("span#pwChk").css({ "color": "green", "font-size": "11px" });
			} else if (uPw != uPwdpChk) {
				$("span#pwChk").html("동일한 비밀번호를 입력해주세요");
				$("span#pwChk").css({ "color": "red", "font-size": "11px" });
			}
		}
	}); // → 비밀번호 확인 소스 끝

	$("#uPw").focusout(function () {
		let uPw = $("#uPw").val();
		uPwreg = /(\w)\1\1/;
		uPwreg2 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]$/;
		uPwRes = uPwreg.test(uPw);
		uPwRes2 = uPwreg2.test(uPw);
		if (uPwRes) {
			alert("같은 문자를 3번이상 사용하실수 없습니다.");
		} else if (uPwRes2 || uPw.length < 8) {
			alert("최소 8 자, 하나 이상의 문자, 하나의 숫자 및 하나의 특수 문자");
		}
	});

        $("select#valSel").change(function() {
		$('#valSel option:selected').each(function() {
			if ($(this).val() == "") {
				$("#uEmail2").val("");
				$("#uEmail2").attr("disabled", false);
			} else {
				$("#uEmail2").val($(this).text());
				$("#uEmail2").attr("disabled", true);
			}
		});
	    });  //→ 이메일 선택요소


 	let yElem = document.querySelector("#birth-year");
	let mElem = document.querySelector("#birth-month");
	let dElem = document.querySelector("#birth-day");
	yElem.addEventListener("click", function () {
		//최초 클릭 시 함수 발생
		//.addEventListener("이벤트명", fuction 함수명(event){})
		for (let i = 1920; i <= 2022; i++) {
			let YearOption = document.createElement('option')
			// createElement메서드 사용 → option 요소생성
			YearOption.setAttribute("value", i) //생성되는 option의 value값에 i를 추가
			YearOption.innerText = i // option태그에 추가한 i의 값을 가져오기
			//innerText → 태그안의 텍스트를 가져오거나 바꾸는 기능
			// birthYearEl의 자식 요소로 추가
			yElem.appendChild(YearOption);
		}
	}, { once: true });
	mElem.addEventListener("click", function () {
		for (let i = 1; i <= 12; i++) {
			let MonthOption = document.createElement('option')
			MonthOption.setAttribute("value", i)
			MonthOption.innerText = i
			mElem.appendChild(MonthOption);
		}
	}, { once: true });
	dElem.addEventListener("click", function () {
		for (let i = 1; i <= 31; i++) {
			let DayOption = document.createElement('option')
			DayOption.setAttribute("value", i)
			DayOption.innerText = i
			dElem.appendChild(DayOption);
		}
	}, { once: true });

	//→ 회원가입 체크 관련 소스

	$("input#chkAll").click(function () {
		let chkToF = $(this).prop("checked");
		$("input.useAgree").prop("checked", chkToF);
	});  // → 정방향 전체 체크


	$(".joinAgree .termArea input[type=checkbox]").click(function () {
		let boolChk = false;
		let chk0 = $(".joinAgree .termArea").eq(0).find("input").prop("checked");
		let chk1 = $(".joinAgree .termArea").eq(1).find("input").prop("checked");
		let chk2 = $(".joinAgree .termArea").eq(2).find("input").prop("checked");
		let chk3 = $(".joinAgree .termArea").eq(3).find("input").prop("checked");
		let chk4 = $(".joinAgree .termArea").eq(4).find("input").prop("checked");
		if (chk0 && chk1 && chk2 && chk3 && chk4) boolChk = true;
		$(".joinAgree input#chkAll").prop("checked", boolChk);
	});  // → 역방향 전체 체크

	$("input#sub_chkAll").click(function () {
		let chkToF = $(this).prop("checked");
		$("input.socialAgree").prop("checked", chkToF);
	});
	$(".socialAgree input[type=checkbox]").click(function () {
		let boolChk = false;
		let chk0 = $(".socialAgree").eq(0).find("input").prop("checked");
		let chk1 = $(".socialAgree").eq(1).find("input").prop("checked");
		if (chk0 && chk1) boolChk = true;
		$("input#sub_chkAll").prop("checked", boolChk);
	});
	// → 혜택,정보 수신 동의 정방향 전체 체크

	$("button#joinBtn").click(function () {
		let chk0 = $(".joinAgree .termArea").eq(0).find("input").prop("checked");
		let chk1 = $(".joinAgree .termArea").eq(1).find("input").prop("checked");
		let chk4 = $(".joinAgree .termArea").eq(4).find("input").prop("checked");
		if (chk0 == false) {
			alert("이용약관 동의(필수)체크해주세요");
			$(".joinAgree .termArea").eq(0).find("input");
			$(".joinAgree .termArea").eq(0).focus();
		} else if (chk1 == false) {
			alert("개인정보 수집 · 이용동의(필수)체크해주세요");
			$(".joinAgree .termArea").eq(0).find("input");
		} else if (chk4 == false) {
			alert("본인은 만14세이상입니다(필수)체크해주세요");
			$(".joinAgree .termArea").eq(0).find("input");
		} else {
			$("form#joinFrm").submit();
		}
	});
	// → 개인정보 필수체크 소스 //
	
	
	$("button#dpChk").click(function () {
		let uId = $("#uId").val();
        let uIdEfck = /[^a-z|A-Z|0-9]/g;
        let uIdEfRes = uIdEfck.test(uId);
		if (uId == "") {
			alert("아이디를 입력");
			$("#uId").focus();
		}else if(uIdEfRes || uId.length < 5){
			alert("영어대/소문자, 숫자 조합 최소5글자만 가능합니다.");
			$("#uId").focus();
		}else{
			let uId = $("input[name=uId]").val();

			let url = "/Member/idCheck.jsp?uId=" + uId;
			let nickName = "idChkPop";

			let w = screen.width;     // 1920
			let popWidth = 350;
			let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치

			let h = screen.height;    // 1080
			let popHeight = 210;
			let topPos = (h - popHeight) / 2;


			let prop = "width=" + popWidth + ", height=" + popHeight;
			prop += ", left=" + leftPos + ", top=" + topPos;
			window.open(url, nickName, prop);
		}
	});

	$("button#cBtn").click(function () {
		let chkVal = $("input[name=chk]").val();
		window.opener.document.getElementById("checked_id").setAttribute("value", chkVal);

		window.close();
	});
	//→ uId중복확인 버튼소스//


});
// → $(function(){}) 익명함수 종료
