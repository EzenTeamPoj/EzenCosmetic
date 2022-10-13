$(function() {







		/* 공지사항 게시판 리스트 페이지 글쓰기 버튼 시작 /bbs_Notice/noticebbs.jsp */
	$("#loginAlertBtn").click(function() {
		alert("관리자만 게시글을 작성하실 수 있습니다.");
	});

	$("#NoticeWriteBtn").click(function() {
		location.href = "/bbs_Notice/write.jsp";
	});
	/* 공지사항 게시판 리스트 페이지 글쓰기 버튼 끝 /bbs_Notice/noticebbs.jsp */


	$("button#personalBtn").click(function() {

		$("iframe#ifrNotice").css({
			"display": "none"

		});
		$("iframe#ifrInquire").css({
			"display": "block"

		});

	});



$("button#noticeBtn").click(function() {

		$("iframe#ifrNotice").css({
			"display": "block"

		});

		$("iframe#ifrInquire").css({
			"display": "none"

		});
	});
$("button#reset").click(function(){

 history.back();
});



	/* 글쓰기 페이지 게시글 등록 시작 /bbs/write.jsp */
	$("#regBtn").click(function() {
		let subject = $("#subject").val().trim();

		if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#writeFrm").attr("action", "/bbs_Inquire/writeProc.jsp");
			$("#writeFrm").submit();
		}

	});

	/* 글쓰기 페이지 게시글 등록 끝 /bbs/write.jsp */



	/* 글쓰기 페이지 게시글 수정 시작 /bbs_Inquire/read.jsp -> modify.jsp */
	$("#modInqBtn").click(function() {

		let nowPageInq = $("input#nowPageInq").val().trim();
		let num = $("input#num").val().trim();

		let url="/bbs_Inquire/modify.jsp?";
		url += "num="+num;
			url += "&nowPage="+nowPageInq;
		location.href = url;


	});

	/* 글쓰기 페이지 게시글 수정 끝  /bbs_Inquire/read.jsp -> modify.jsp */






	/* 공지사항 페이지 게시글 관리자 수정 시작 /bbs_Notice/read.jsp */


	$("td.read>button#modBtn").click(function() {

		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();

		let url = "/bbs_Notice/modify.jsp?";
		url += "num="+num;
			url += "&nowPage="+nowPage;
			location.href=url;


	});

	/* 공지사항 페이지 게시글 관리자 수정 끝 /bbs_Notice/read.jsp */

	/* 게시글 수정페이지에서 수정내용 전송 시작 /bbs_Notice/modify.jsp */


	$("td.update>button#modNotBtn").click(function(){
		let asubject = $("td>input#asubject").val().trim();



			if (asubject == "") {
				alert("제목은 필수입력입니다.");
				$("#asubject").focus();
			} else {

				$("#modifyNotProcFrm").submit();

			}

	});	
	/* 게시글 수정페이지에서 수정내용 전송 끝 /bbs_Notice/modify.jsp */


$("#backBtn").click(function(){

		location.href="/bbs_Notice/noticebbs.jsp"
	});



	/* 게시글 삭제버튼 시작 /bbs_Notice/read.jsp */
	$("button#delNotBtn").click(function() {

		let chkTF = confirm("게시글을 삭제하시겠습니까?");


		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let num = $("input#num").val().trim();



			let url = "/bbs_Notice/delete.jsp?";
			url += "num=" + num + "&nowPage=" + nowPage;

			location.href = url;
		} else {
			alert("취소하셨습니다.");
		}

	});
	/* 게시글 삭제버튼 끝 /bbs/read.jsp */

/* <공지 사항> 검색 결과를 유지한 리스트페이지 이동 시작 /bbs/read.jsp */
	$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();


		let url = "/bbs_Notice/noticebbs.jsp?nowPage=" + param;		    

		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /bbs/read.jsp */

/* Noticebbs리스트 검색 시작 /bbs_Notice/noticebbs.jsp */	
	$("button#searchBtn").click(function(){
		let keyWord = $("#keyWord").val();
		// 검색어에서는 .trim()을 지양하는 추세
		// 단 로그인 회원 가입 회원정보수정에서 사용하는
		// ID에는 입력값 전후의 공백을 제거한다.
		//alert("keyWord : " + keyWord + "/nKeyWOrd 글자수 : " +keyWord.length );
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});	
	/* Noticebbs리스트페이지 검색 끝 /bbs_Notice/noticebbs.jsp */	

/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동

    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord

	let param = "/bbs_Notice/noticebbs.jsp?nowPage="+p1;	    
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /bbs/list.jsp */
function moveBlock(p1, p2, param3) {    // 블럭 이동 ,전 블럭의  ''마지막'' 페이지로 이동함 p1: nowBlock-1 

	let pageNum = parseInt(p1);  // 이전 블럭의 시작페이지로 이동할 때 사용
	let pagePerBlock = parseInt(p2);	 //5

	alert("p1(moveBlock) : " + p1 + "\np2(pagePerBlock) : " + p2 );

    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord



	if(param3=='pb'){
		 param = "/bbs_Notice/noticebbs.jsp?nowPage="+(moveBlock*pagePerBlock);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 

	}else if(param3=='nb'){
		param = "/bbs_Notice/noticebbs.jsp?nowPage="+(pagePerBlock*(moveBlock-1)+1);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 

	}



	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs/list.jsp */


});


/* 공지사항 상세내용 보기 페이지 이동 시작 /bbs_Notice/noticebbs.jsp => read.jsp */
function modify(p1, p2) {



	let param = "/bbs_Notice/read.jsp?num=" + p1;
	param += "&nowPage=" + p2;

	location.href = param;


}
/* 공지사항 상세내용 보기 페이지 이동 끝 /bbs_Notice/noticebbs.jsp => read.jsp  *//**
 * 
 */