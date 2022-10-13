$(function(){

	$("button#joinBtn").click(function(){

    //이메일 주소 병합 소스 만들기 시작 //
	let uEmail1 = $("input#uEmail1").val().trim();
	let uEmail2 = $("input#uEmail2").val().trim();
	let uEmail =uEmail1+"@"+uEmail2;
	$("input#uEmail").val(uEmail);
     //이메일 주소 병합 소스 만들기 끝 //
         
	 // 주소 병합 소스만들기 시작 //
      let pcode = $("input#postcode").val().trim();
      let addr= $("input#address").val().trim();    
      let uAddr=  pcode+ addr;
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
      

//////////////////////////  비밀번호 유효성 검사 시작  //////////////////////////
     $("#uPw").focusout(function(){
     let uPw =$("#uPw").val().trim();
     $("#uPw").val(uPw);
     let regExp=/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])$/;
     let regExpRes = regExp.test(uPw);
     //최소 8 자, 최소 하나의 문자 및 하나의 숫자 및 하나의 특수문자
     if(regExpRes || uPw.length<8){
	 alert("비밀번호는 최소8자 , 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.");
     }
     });
   

        //비밀번호 확인 소스 시작  //
		    $("#uPwdpChk").focusout(function(){ 
		    let uPw =$("#uPw").val().trim();
		    let uPwdpChk = $("#uPwdpChk").val().trim();
		
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
////////////////////////// 비밀번호 유효성 검사 끝 //////////////////////////
     

// 이메일 선택요소 시작//
    $("select#valSel").change(function(){
	$('#valSel option:selected').each(function(){   
    if($(this).val() == ""){
	$("#uEmail2").val("");
	$("#uEmail2").attr("disabled",false);
    } else {
    $("#uEmail2").val($(this).text());
	$("#uEmail2").attr("disabled", true);
	}
    });
    });
// 이메일 선택요소 종료//
////////////////////////// 체크관련 소스 시작  //////////////////////////
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
		$(".joinAgree .termArea").eq(1).find("input");

	}else if(chk4 == false){
		alert("본인은 만14세이상입니다(필수)체크해주세요");
		$(".joinAgree .termArea").eq(4).find("input");
	} else{
		$("form#joinFrm").attr("action","/Member/Join_Proc.jsp").submit();
	}
    });
   //개인정보 필수체크 소스 종료 //

//////////////////////////  체크 관련 소스  종료 //////////////////////////
  


// uId중복확인 버튼소스 시작 //
  $("button#dpChk").click(function(){
	
	let uId = $("#uId").val().trim(); 
	$("#uId").val(uId);
	let regExp = /[^a-z|A-Z|0-9]/g;     // 아이디 유효성검사 : 영어대/소문자, 숫자 조합 최소5글자
    let rExpRes = regExp.test(uId);
	
	if(rExpRes || uId.length <5){
		alert("영어대/소문자, 숫자 조합 최소5글자만 가능합니다.");
			$("#uId").focus();
	}else{
	
	        let url = "/Member/idCheck.jsp?uId=" + uId;
			let nickName = "idChkPop";
	
			let w = screen.width;     // 1920
			let popWidth = 400;
			let leftPos = (w - popWidth)/2; // left Position 팝업창 왼쪽 시작위치
	
			let h = screen.height;    // 1080
			let popHeight = 200;
			let topPos = (h - popHeight)/2; 		
			
	
			let prop = "width="+ popWidth +", height="+ popHeight;
				  prop += ", left=" + leftPos + ", top=" + topPos; 
			window.open(url, nickName, prop);
       }
	});
	
	$("#cBtn").click(function(){
		window.close();
		opener.regFrm.uId.focus();
	});
	// uId중복확인 버튼소스 종료 //

});
//익명 함수 종료