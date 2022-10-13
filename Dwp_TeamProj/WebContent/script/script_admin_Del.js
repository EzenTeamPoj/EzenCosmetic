$(function(){

		//회원 목록 페이지 개별 삭제 시작
	$("button.btnDel").click(function(){
		
		let procChk= confirm("해당 회원목록을 삭제하시겠습니까?"); 
	
	   if(procChk){
	    let del = $(this).val();
		location.href ="/Member/delMemberProc.jsp?multiFlag=s&num="+del;
		}else{
		 alert("취소하셨습니다");
		}
	})
	//회원 목록 페이지 개별 삭제 끝
	//회원 목록 페이지 개별 삭제 끝
		
	//회원 목록 삭제 대상 선택 체크박스 시작
	
		//회원 다중 삭제 시작 
   $("button#multiDel").click(function(){			
			
			let chkCnt = 0;   // 체크박스 체크 상태 개수
			let len = $("input.DelChk").length;   // 회원 목록에 표시되는 체크박스 개수
			
			for (let i=0; i<len; i++) {
				let chkToF = $("input.DelChk").eq(i).prop("checked");
				if(chkToF)  chkCnt++;
			}
			
			if(chkCnt == 0) {
				alert("삭제하실 아이디를 선택하세요.");
			} else {
				
				let procChk = confirm("해당 회원목록을 삭제하시겠습니까?");
				
				if (procChk) {
					
					$("form#memDelForm")
						.attr("action", "/Member/delMemberProc.jsp")
						.submit();
				
				//.attr("action", "/MemberList/deleteMultiProc.jsp")
				} else {
					alert("취소하셨습니다.");
				}
			
				
			}
				
		});
	//회원 다중 삭제 끝



// 체크박스 전체 선택/해체 시작
$("input#chkAll").click(function(){
		let chkToF = $(this).prop("checked");
		$("input.DelChk").prop("checked",chkToF);
		});	

// 체크박스 전체 선택/해체 끝

//회원 목록 삭제 대상 전체선택 해제 시작
$("input.DelChk").click(function(){
		let inputlen = $("input.DelChk").length;
		let chklen = $("input.DelChk:checked").length;
		if(inputlen != chklen){
			$("input#chkAll").prop("checked",false);
		}else{
			$("input#chkAll").prop("checked",true);
		}
	});
//회원 목록 삭제 대상 전체선택 해제 끝
});


////////////// 회원 정보 수정 시작 //////////////
		
		$("button#updateBtn").click(function(){
			$("form#updateFrm").attr("action", "/update/memUpdateProc.jsp");
		});
				
		////////////// 회원 정보 수정 끝 //////////////