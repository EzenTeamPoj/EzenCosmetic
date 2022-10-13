$(function() {

	$("button#select_period_buy").click(function(){
		location.href="/bbs_Inquire/buyList.jsp";
	})

	/* 1:1 문의 버튼 눌렀을 때*/
	$("button#personalBtn").click(function() {

		$("iframe#ifrNotice").css({
			"display": "none"

		});
		$("iframe#ifrInquire").css({
			"display": "block"

		});

	});
	/* 1:1 문의 버튼 눌렀을 때*/



	/* 1:1문의 게시판 리스트 페이지 글쓰기 버튼 시작 /bbs_Inquire/inquirebbs.jsp */
	$("#loginAlertBtn").click(function() {
		alert("로그인 후 게시글을 작성하실 수 있습니다.");
		window.parent.parent.location.href = "/Member/Login.jsp";
	});



	$("#inqBtn").click(function() {
		location.href = "/bbs_Inquire/write.jsp";
	});






	/* 1:1문의 수정페이지 게시글 등록 시작 /bbs_Inquire/write.jsp */
	$("#regBtn").click(function() {
		let subject = $("#subject").val().trim();

		if (subject =="") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#writeFrm").attr("action", "/bbs_Inquire/writeProc.jsp");
			$("#writeFrm").submit();
		}

	});

	/* 1:1문의 수정페이지 게시글 등록 끝 /bbs_Inquire/write.jsp */



	/* 1:1문의 수정페이지 게시글 입력 버튼 시작 /bbs_Inquire/read.jsp -> modify.jsp */
	$("#modInqBtn").click(function() {

		let nowPageInq = $("input#nowPageInq").val().trim();
		let num = $("input#num").val().trim();

		let url="/bbs_Inquire/modify.jsp?";
		url += "num="+num;
			url += "&nowPage="+nowPageInq;
		location.href = url;


	});

	/* 1:1문의 수정페이지게시글 입력 버튼 끝  /bbs_Inquire/read.jsp -> modify.jsp */


	/* 1:1문의 수정페이지에서 수정내용 전송 시작 /bbs_Inquire/modify.jsp */


	$("td.update>button#modFinBtn").click(function(){

		let subject = $("td>input#subject").val().trim();


			if (subject == "") {
				alert("제목은 필수입력입니다.");
				$("#subject").focus();
			} else {

				$("#modifyInqProcFrm").submit();
			}

	});	
	/* 1:1문의 수정페이지에서 수정내용 전송 끝 /bbs_Inquire/modify.jsp */


	/* 게시글 삭제버튼 시작 /bbs_Inquire/read.jsp */
	$("button#delInqBtn").click(function() {

		let chkTF = confirm("게시글을 삭제하시겠습니까?");


		if (chkTF) {
			let nowPage = $("input#nowPageInq").val().trim();
			let num = $("input#num").val().trim();



			let url = "/bbs_Inquire/delete.jsp?";
			url += "num=" + num + "&nowPage=" + nowPage;

			location.href = url;
		} else {
			alert("취소하셨습니다.");
		}

	});
	/* 게시글 삭제버튼 끝 /bbs_Inquire/read.jsp */



/*  검색 결과를 유지한 리스트페이지 이동 시작 /bbs_Inquire/read.jsp */
	$("td>button#listBtn").click(function(){


		let param = $("#nowPageInq").val().trim();


		let url = "/bbs_Inquire/list.jsp?nowPage=" + param;		    

		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /bbs_Inquire/read.jsp */



	$("button#goListMainBtn").click(function(){

	window.parent.location.href="/bbs_Notice/ServiceMain.jsp";

	});


/*/////////////////////////////////////////////read 답변 버튼*/

$("td.read>button#inqReplyBtn").click(function(){


		let uId = $("input#uId_Session").val().trim();

		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();

		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		let url = "/bbs_Inquire/reply.jsp?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
			url += "&keyField="+p3;
	     	url += "&keyWord="+p4; 

		if(uId==null||uId==""){
		alert("회원만 입력가능합니다");
		location.href ="/Member/Login.jsp";

		} else {

		location.href=url;

		}





	});

	$("td.reply>button#inqReplyBtn").click(function(){

		let subject = $("#subject").val().trim();

		if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {		
			$("#replyFrm").submit();
		}

	});
/*/////////////////////////////////////////////답변 버튼*/


/* 리스트페이지 검색 시작 /bbs_Inquire/list.jsp */	
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
	/* 리스트페이지 검색 끝 /bbs_Inquire/list.jsp */	


	/* 검색 결과를 유지한 리스트페이지 이동 시작 /bbs_Inquire/read.jsp */
	$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord

		let url = "/bbs_Inquire/list.jsp?nowPage=" + param;		    
		    url += "&keyField="+p3;
	     	url += "&keyWord="+p4 ; 
		location.href=url;
	});
	/* 검색 결과를 유지한 리스트페이지 이동 끝 /bbs_Inquire/read.jsp */

	$("#backBtn").click(function(){

		location.href="/bbs_Inquire/list.jsp"
	});


	$("#chkPwBtn").click(function(){
		let bbsPw = $("#bbsPw").val();
		let num = $("input#num").val();
		let nowPage = $("input#nowPage").val();
		let url = "/bbs_Inquire/checkPwProc.jsp?num="+num;
		     url+= "&nowPage="+nowPage;
             url+= "&bbsPw="+bbsPw;

		if(bbsPw==""||bbsPw==null){
			alert("입력해주세요");

		}else {
			location.href = url; 
		}

	});



/* 1:1 문의 상세내용 보기 페이지 이동 시작 /bbs_Inquire/list.jsp => read.jsp */
function read(p1, p2, p3) {
	let num = p1;
	let nowPage = p2;
	let aId=p3;

	let url ="/bbs_Inquire/read.jsp?";
	url+="num="+num;
	url+="&nowPage="+nowPage;



	let param = "/bbs_Inquire/checkPw.jsp?num="+num;
	param += "&nowPage=" +nowPage;

	if(aId != "" || aId != null){
	location.href=url;
	} else {


	window.open(param,"","width=500px,height=500px");
	}

}

/* 1:1 문의 상세내용 보기 페이지 이동 끝 /bbs_Inquire/list.jsp => read.jsp */



/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동



    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord

	let param = "/bbs_Inquire/list.jsp?nowPage="+p1;	    
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /bbs_Inquire/list.jsp */
function moveBlock(p1, p2, param3) {    // 블럭 이동 ,전 블럭의  ''마지막'' 페이지로 이동함 p1: nowBlock-1 

	let pageNum = parseInt(p1);  // 이전 블럭의 시작페이지로 이동할 때 사용
	let pagePerBlock = parseInt(p2);	 //5

	alert("p1(moveBlock) : " + p1 + "\np2(pagePerBlock) : " + p2 );

    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord



	if(param3=='pb'){
		 param = "/bbs_Inquire/list.jsp?nowPage="+(moveBlock*pagePerBlock);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 

	}else if(param3=='nb'){
		param = "/bbs_Inquire/list.jsp?nowPage="+(pagePerBlock*(moveBlock-1)+1);
	     param += "&keyField="+p3;
	     param += "&keyWord="+p4 ; 

	}



	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs_Inquire/list.jsp */

});