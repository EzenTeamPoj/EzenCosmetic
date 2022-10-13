$(function(){
	
	
	/* 리스트 페이지 글쓰기 버튼 시작 /bbs/list.jsp */	
	$("#loginAlertBtn").click(function(){		
		alert("로그인 후 게시글을 작성하실 수 있습니다.");
	});	
	$("#writeBtn").click(function(){		
		location.href="/bbs_Often/write.jsp";
	});
	/* 리스트 페이지 글쓰기 버튼 끝 /bbs/list.jsp */
	
	
	/* 글쓰기 페이지 게시글 등록 시작 /bbs/write.jsp */
	$("#regBtn").click(function(){
		let subject = $("#subject").val().trim();		
		
		 if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#writeFrm").attr("action", "/bbs_Often/writeProc.jsp");
			$("#writeFrm").submit();
		}
	
	});	
	
	/* 글쓰기 페이지 게시글 등록 끝 /bbs/write.jsp */
	
	
	/* 게시글 삭제버튼 시작 /bbs/read.jsp */
	$("button#delBtn").click(function(){
		
		let chkTF = confirm("게시글을 삭제하시겠습니까?");
		
		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let num = $("input#num").val().trim();
					
			let p3 = $("#pKeyField").val().trim();  // p3 : keyField
		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		    
			let url = "/bbs_Often/deleteProc.jsp?";
				url += "num="+num+"&nowPage="+nowPage;
				url += "&keyField="+p3;
				url += "&keyWord="+p4;
			location.href=url;
		} else {
			alert("취소하셨습니다.");	
		}
		
	});
	/* 게시글 삭제버튼 끝 /bbs/read.jsp */
	
	
	
	/* 게시글 내용보기페이지에서 수정버튼 시작 /bbs/read.jsp */
	$("td.read>button#modBtn").click(function(){
	
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
				
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
		let url = "/bbs_Often/modify.jsp?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
			url += "&keyField="+p3;
	     	url += "&keyWord="+p4; 
		location.href=url;
	});
	
	/* 게시글 내용보기페이지에서 수정버튼 끝 /bbs/read.jsp */
	
	
	/* 게시글 수정페이지에서 수정내용 전송 시작 /bbs/modify.jsp */
	$("td.update>button#modProcBtn").click(function(){
		let subject = $("#subject").val().trim();
		
		//let keyField = $("#keyField").val().trim();
		//let keyWord = $("#keyWord").val().trim();
		
		if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
		
			//alert("keyField : " + keyField + "\nkeyWord : " + keyWord);
			//return;
			$("#modifyFrm").submit();
		}
	
	});	
	/* 게시글 수정페이지에서 수정내용 전송 끝 /bbs/modify.jsp */
	
	/* 리스트페이지 검색 시작 /bbs/list.jsp */	
	$("button#searchBtn").click(function(){
		let keyWord = $("#keyWord").val().trim();  // 검색어에서는 .trim()을 지양하는 추세
		                                                              // 단, 로드인, 회원가입, 회원정보 수정에서 사용하는 
                                                                      // ID에는 입력값 전후의 공백을 제거한다.
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});	
	/* 리스트페이지 검색 끝 /bbs/list.jsp */	
	
	
	/* 검색 결과를 유지한 리스트페이지 이동 시작 /bbs/read.jsp */
	$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	     
		let url = "/bbs_Often/list.jsp?nowPage=" + param;		    
		    url += "&keyField="+p3;
	     	url += "&keyWord="+p4 ; 
		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /bbs/read.jsp */
	 
    $("#backBtn").click(function(){
	   history.back();
});

	
});
	
	
/* 상세내용 보기 페이지 이동 시작 /bbs/list.jsp => read.jsp */
function read(p1, p2) {
	//p1: num(게시글의 고유번호, 고유값, 키값 => Key Value)
	//p2:nowPage(현재페이지)
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let param = "read.jsp?num="+p1;
	     param += "&nowPage="+p2;
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href=param;
}		
/* 상세내용 보기 페이지 이동 끝 /bbs/list.jsp => read.jsp  */



/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동
	
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord

	let param = "/bbs_Often/list.jsp?nowPage="+p1;	    
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /bbs/list.jsp */
function moveBlock(p1, p2, param3) {    // 블럭 이동

	let moveBlock = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2);
	
    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
	if(param3 == 'pb'){
	     param = "/bbs_Often/list.jsp?nowPage="+(pagePerBlock*moveBlock);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 

	}else if(param3 =='nb'){
		 param = "/bbs_Often/list.jsp?nowPage="+(pagePerBlock*(moveBlock-1)+1);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ;
	}
	location.href =param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs/list.jsp */

