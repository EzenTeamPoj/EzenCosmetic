$(function(){
    //이메일 주소 병합 소스 만들기 시작 //
	$("button#joinBtn").click(function(){
	let aEmail1 = $("input#aEmail1").val().trim();
	let aEmail2 = $("input#aEmail2").val().trim();
	let aEmail =aEmail1+"@"+aEmail2;
	$("input#aEmail").val(aEmail);
     //이메일 주소 병합 소스 만들기 끝 //
         
	 // 주소 병합 소스만들기 시작 //
      let postcode = $("input#postcode").val().trim();
      let address= $("input#address").val().trim();
      let detailAddress =$("input#detailAddress").val().trim();
      let extraAddress = $("input#extraAddress").val().trim();
      let uAddr=  "("+postcode+")"+ address +detailAddress + extraAddress;
      $("input#uAddr").val(uAddr);


    // 주소 병합 소스만들기 끝 //

  });
      
    //비밀번호 확인 소스 시작 //
		$("#aPwdpChk").focusout(function(){ 
		let aPw = $("#aPw").val();
		let aPwdpChk = $("#aPwdpChk").val();
		
		if (aPw != ""|| aPwdpChk != "") {
			if(aPw == aPwdpChk){
			$("span#pwChk").html("비밀번호가 일치합니다");
			$("span#pwChk").css({"color":"green","font-size":"11px"});
	    } else if(aPw != aPwdpChk) {
			$("span#pwChk").html("동일한 비밀번호를 입력해주세요");
			$("span#pwChk").css({"color":"red" , "font-size": "11px"});
			}
		}
	});
    //비밀번호 확인 소스 끝 //

     // 이메일 선택요소 시작//
     $("select#valSel").change(function(){
     $("input#aEmail2").val($(this).val());
	
     });
     // 이메일 선택요소 종료//


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



