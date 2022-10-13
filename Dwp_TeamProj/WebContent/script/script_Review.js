$(function(){
	/* 리뷰게시판 글쓰기 버튼 시작 /bbs/list.jsp */	
	$("#loginAlertBtn").click(function(){		
		alert("로그인 후 게시글을 작성하실 수 있습니다.");
	});	
	
	
	$("#writeBtn").click(function(){
		let orderCnt = $("input#orderCnt").val();
		if(orderCnt > 0) {
			let prodNum = $("input#prodNum").val();
			location.href="/bbs_Review/reviewPost.jsp?prodNum="+prodNum;	
		} else {
			alert("상품을 구매한 고객님만 리뷰를 작성할 수 있습니다.");
		}
	});
	
	
	/* 리뷰게시판 페이지 글쓰기 버튼 끝 /bbs/list.jsp */
	
	
	/* 글쓰기 페이지 게시글 등록 시작 /bbs/write.jsp */
	$("#regBtn").click(function(){
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
	
	/* 상품 게시글 내용보기페이지에서 수정버튼 시작 /bbs/read.jsp */
	$("button.modBtn").click(function(){
		let nowPage = $("input#nowPage").val().trim();
		let prodNum	= $("input#prodNum").val().trim();
		let totalReviewNum = $(this).siblings("input.totalReviewNum").val().trim();	
		
				
		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	
		let url = "/bbs_Review/reviewMod.jsp?";
			url +="prodNum="+prodNum;
			url += "&totalReviewNum="+totalReviewNum+"&nowPage="+nowPage;
			url += "&keyField="+p3;
			url += "&keyWord="+p4;
		location.href=url;
	});
	
	/* 상품 게시글 내용보기페이지에서 수정버튼 끝 /bbs/read.jsp */
	
	
		/* 글쓰기 페이지 게시글 수정 시작 /bbs/modify.jsp */
	$("#modProcBtn").click(function(){
		let subject = $("#subject").val().trim();		
		
		 if (subject == "") {
			alert("제목은 필수입력입니다.");
			$("#subject").focus();
		} else {
			$("#modFrm").attr("action", "/bbs_Inquire/modifyProc.jsp");
			$("#modFrm").submit();
		}
	
	});	
	
	/* 글쓰기 페이지 게시글 수정 끝 /bbs/modify.jsp */
	
	
	
	/* 게시글 삭제버튼 시작 /bbs/read.jsp */
	$("button.delBtn").click(function(){
		
		let chkTF = confirm("게시글을 삭제하시겠습니까?");
		
		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let prodNum	= $("input#prodNum").val().trim();
			let totalReviewNum = $(this).siblings("input.totalReviewNum").val().trim();		
			let p3 = $("#pKeyField").val().trim();  // p3 : keyField
		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		    
			let url = "/bbs_Review/reviewDelProc.jsp?";
				url +="prodNum="+prodNum;
				url += "&totalReviewNum="+totalReviewNum+"&nowPage="+nowPage;
				url += "&keyField="+p3;
				url += "&keyWord="+p4;
			location.href=url;
		} else {
			alert("취소하셨습니다.");	
		}
		
	});
	/* 게시글 삭제버튼 끝 /bbs/read.jsp */
	
	
	/* 게시물 검색 시작 */
	$("button#searchBtn").click(function(){				//검색어에서는 .trim()을 지양하는 추세
		let keyWord = $("#keyWord").val().trim();		//단 로그인, 회원가입 등에서는 ID에는 입력값 전후의 공백을 제거한다
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});	

	/* 게시물 검색 끝 */
	/* 리뷰게시물 추천버튼 시작 */
	$("button.recommendBtn").click(function(){
		let nowPage = $("input#nowPage").val();
		let prodNum	= $("input#prodNum").val();
		let totalReviewNum = $(this).siblings("input.totalReviewNum").val();	

		let p3 = $("#pKeyField").val().trim();  // p3 : keyField
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		
		let url = "/bbs_Review/reviewRecomProc.jsp?";
			url +="prodNum="+prodNum;
			url += "&totalReviewNum="+totalReviewNum+"&nowPage="+nowPage;
			url += "&keyField="+p3;
			url += "&keyWord="+p4;
		location.href=url;
	});
	
	/* 리뷰게시물 추천버튼 끝 */

	
});


