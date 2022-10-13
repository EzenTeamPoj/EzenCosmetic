$(function(){
    //이메일 주소 병합 소스 만들기 시작 //
	$("button#joinBtn").click(function(){
	let uEmail1 = $("input#uEmail1").val().trim();
	let uEmail2 = $("input#uEmail2").val().trim();
	let uEmail =uEmail1+"@"+uEmail2;
	$("input#uEmail").val(uEmail);
     //이메일 주소 병합 소스 만들기 끝 //
         
	 // 주소 병합 소스만들기 시작 //
      let postcode = $("input#postcode").val().trim();
      let address= $("input#address").val().trim();
      let detailAddress =$("input#detailAddress").val().trim();
      let extraAddress = $("input#extraAddress").val().trim();
      let uAddr=  "("+postcode+")"+ address+" "+detailAddress +" "+extraAddress;
      $("input#uAddr").val(uAddr);


    // 주소 병합 소스만들기 끝 //

	 //나이,생년월일 전송 시작
    const today = new Date();
    let Year = $("input#Year").val().trim();
    let Month =$("input#Month").val().trim();
    let Day = $("input#Day").val().trim();
   let uBirth = Year+Month+Day;
    let age = today.getFullYear()- Year+1;
   $("input#uAge").val(age);
   $("input#uBirth").val(uBirth);
	console.log(uBirth);
     //나이,생년월일 전송 끝

  });
      
    //비밀번호 확인 소스 시작 //
		$("#uPwdpChk").focusout(function(){ 
		let uPw = $("#uPw").val();
		let uPwdpChk = $("#uPwdpChk").val();
		
		if (uPw != ""|| uPwdpChk != "") {
			if(uPw == uPwdpChk){
			$("span#pwChk").html("비밀번호가 일치합니다");
			$("span#pwChk").css({"color":"green","font-size":"11px"});
	    } else if(uPw != uPwdpChk) {
			$("span#pwChk").html("동일한 비밀번호를 입력해주세요");
			$("span#pwChk").css({"color":"red" , "font-size": "11px"});
			}
		}
	});
    //비밀번호 확인 소스 끝 //

     // 이메일 선택요소 시작//
     $("select#valSel").change(function(){
     $("input#uEmail2").val($(this).val());
	
     });
     // 이메일 선택요소 종료//
     

     // 정방향 전체 체크 적용 시작 //
      $("input#chkAll").click(function(){
	  let chkToF =  $(this).prop("checked");
	  $("input.useAgree").prop("checked",chkToF);
	 });
    // 정방향 전체 체크 적용 끝 //


	
	
	 
	// 역방향 전체 체크 적용 시작 //
	$(".joinAgree .termArea input[type=checkbox]").click(function(){
		
		let  boolChk = false;				

		let chk0 =$(".joinAgree .termArea").eq(0).find("input").prop("checked");
		let chk1 =$(".joinAgree .termArea").eq(1).find("input").prop("checked");
		let chk2 =$(".joinAgree .termArea").eq(2).find("input").prop("checked");
		let chk3 =$(".joinAgree .termArea").eq(3).find("input").prop("checked");
		let chk4 =$(".joinAgree .termArea").eq(4).find("input").prop("checked");
		
		if (chk0 && chk1 && chk2 && chk3 && chk4) {
			boolChk = true;    // 4개의 필수약관 모두 체크 되었을 때 실행됨.
		}
		
		$(".joinAgree input#chkAll").prop("checked", boolChk);
	   });
	// 역방향 전체 체크 적용 종료 //
	
	// 무료배송, 할인쿠폰 등 혜택/정보 수신 동의 정방향 전체 체크 적용 끝  //
	  $("input#sub_chkAll").click(function(){
	  let chkToF =  $(this).prop("checked");
	  $("input.socialAgree").prop("checked",chkToF);

       });
      $(".socialAgree input[type=checkbox]").click(function(){
      let  boolChk = false;	
      let chk0 = $(".socialAgree").eq(0).find("input").prop("checked");
      let chk1 = $(".socialAgree").eq(1).find("input").prop("checked");	   
      if(chk0 && chk1){
        boolChk = true;
     }
	  $("input#sub_chkAll").prop("checked", boolChk);
     });
    // 무료배송, 할인쿠폰 등 혜택/정보 수신 동의 정방향 전체 체크 적용 끝   //

   //개인정보 필수체크 소스 시작
   $("button#joinBtn").click(function(){
	let chk0 =$(".joinAgree .termArea").eq(0).find("input").prop("checked");
	let chk1 =$(".joinAgree .termArea").eq(1).find("input").prop("checked");
	let chk4 =$(".joinAgree .termArea").eq(4).find("input").prop("checked");
	
	if(chk0 == false){
		alert("이용약관 동의(필수)체크해주세요");
		$(".joinAgree .termArea").eq(0).find("input");
		$(".joinAgree .termArea").eq(0).focus();
	} else if(chk1 == false){
		alert("개인정보 수집 · 이용동의(필수)체크해주세요");
		$(".joinAgree .termArea").eq(0).find("input");

	}else if(chk4 == false){
		alert("본인은 만14세이상입니다(필수)체크해주세요");
		$(".joinAgree .termArea").eq(0).find("input");
	} else{
		$("form#joinFrm").attr("action","/Member/Join_Proc.jsp").submit();
	}
    });
   //개인정보 필수체크 소스 종료 //

  // uId중복확인 버튼소스 시작 //
  $("button#dpChk").click(function(){
	
	let uId = $("#uId").val().trim(); 
	$("#uId").val(uId);
	let regExp = /[^a-z|A-Z|0-9]/g;
    let rExpRes = regExp.test(uId);
	if(rExpRes){
		alert("영어대/소문자, 숫자 조합만 가능합니다.");
			$("#uId").focus();
	}else{
	let url = "/Member/idCheck.jsp?uId=" + uId;
			let nickName = "idChkPop";
	
			let w = screen.width;     // 1920
			let popWidth = 480;
			let leftPos = (w - popWidth) / 2; // left Position 팝업창 왼쪽 시작위치
	
			let h = screen.height;    // 1080
			let popHeight = 320;
			let topPos = (h - popHeight) / 2; 		
			
	
			let prop = "width="+ popWidth +", height="+ popHeight;
				  prop += ", left=" + leftPos + ", top=" + topPos; 
			window.open(url, nickName, prop);
  }
	});
	
	$("#cBtn").click(function(){
		window.close();
		opener.regFrm.uId.focus();    
		// DOM으로 접근
		// opener객체는 팝업창을 실행한 부모페이지를 지칭함.
	});
	// uId중복확인 버튼소스 종료 //

});
	//로그인 Select 시작 //
	
	$("td#uIdSelect").click(function(){
		$(this).css({"border":"1px solid #fba6cc"
		,"border-bottom":"none", "color":"#fba6cc"})
		$("td#phoneSelect").css({
			"border-top":"1px solid #aaa",
			"border-right":"1px solid #aaa",
			"border-bottom": "1px solid #fba6cc"
			,"color":"#aaa"});
		$("input#uId").attr("placeholder","아이디");
		
	});
	$("td#phoneSelect").click(function(){
		$(this).css({"border":"1px solid #fba6cc"
		,"border-bottom":"none", "color":"#fba6cc"})
		$("td#uIdSelect").css({
			"border-top":"1px solid #aaa",
			"border-right":"1px solid #aaa",
			"border-bottom": "1px solid #fba6cc",
			"color":"#aaa"});
		$("input#uId").attr("placeholder","휴대폰번호");
	});
	
	//로그인 Select 종료 //



