$(function(){
	
	 //이메일 주소 병합 소스 만들기 시작
	$("button#modBtn").click(function(){
	let uEmail1 = $("input#uEmail1").val();
	let uEmail2 = $("input#uEmail2").val();
	let uEmail =uEmail1+"@"+uEmail2;
	$("input#uEmail").val(uEmail);
     //이메일 주소 병합 소스 만들기 끝
    
	 // 주소 병합 소스만들기 시작
      let postcode = $("input#postcode").val().trim();
      let address= $("input#address").val().trim();
      let detailAddress =$("input#detailAddress").val().trim();
      let extraAddress = $("input#extraAddress").val().trim();
      let uAddr=  "("+postcode+")"+ address +detailAddress + extraAddress;
      $("input#uAddr").val(uAddr);

    // 주소 병합 소스만들기 끝
	});
	// 이메일 선택요소 시작
     $("select#valSel").change(function(){
     $("input#uEmail2").val($(this).val());
   
     // 이메일 선택요소 시작
	});
	
	});