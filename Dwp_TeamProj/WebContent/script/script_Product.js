$(function(){
	


	/* 상품등록 시 필수 입력 사항 유효성 검사 시작 */
	$("form#prodPostFrm").submit(function(){
		let pType = $("select#pType").val();
		if(pType==""||pType) {
			alert("상품종류를 선택해주세요");
			return false;
		}
	});
	
	$("input#noneLabel").change(function(){
		let noneLabel = $(this).prop("checked");
		if (noneLabel) {
			$("input.sellLabel").eq(0).prop("checked", false);
		
			$("input.sellLabel").eq(1).prop("checked", false);
		
			$("input.sellLabel").eq(2).prop("checked", false);
			
		} 
	});
	
	$("input.sellLabel").change(function(){
		let sellLabel = $(this).prop("checked");
		if (sellLabel) {
			$("input#noneLabel").prop("checked", false);
		} else {
			$("input#noneLabel").prop("checked", true);
		}
	});
	
	$("input.price").keyup(function(){
		let oriPrice = $("input#oriPrice").val();
		oriPrice = parseInt(oriPrice);
		let sellPrice = $("input#sellPrice").val();
		sellPrice = parseInt(sellPrice);
		
		if(oriPrice > sellPrice ) {
			$("input#saleLabel").prop("checked", true);
			$("input#noneLabel").prop("checked", false);
		} else {
			$("input#saleLabel").prop("checked", false);
		}
	});
	
	
	
	
	/* 상품등록 시 필수 입력 사항 유효성 검사 끝 */
	
	/* 상품리스트에서 정렬순서 버튼 시작 */
	$("input.orderBy").change(function(){
		let nowPage = $("input#nowPage").val().trim();
					
		let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		
		let p5 = $(this).val(); 
		let p6 = $("#typeSearch").val();
		
		let param = "/product/prodList.jsp?";
			param += "&nowPage="+nowPage;
			param += "&keyWord="+p4;
			param += "&orderBy="+p5;
			param += "&typeSearch="+p6;
		location.href=param; 
	});
	
	/* 상품리스트에서 정렬순서 버튼 끝 */
	
	
	/* 상품리스트에서 검색 버튼 시작 */
	$("button#searchBtn").click(function(){
	/*	let nowPage = $("input#nowPage").val().trim(); */
					
		let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		
		let p5 = $("#orderBy").val();
		let p6 = $("#typeSearch").val();
		
		let param = "/product/prodList.jsp?";
			param += "&keyWord="+p4;
			param += "&orderBy="+p5;
			param += "&typeSearch="+p6;
		location.href=param; 
	});
	
	/* 상품리스트에서 검색 버튼 끝 */

	/* 상품 게시글에서 주문 수량 증감 버튼 시작 /bbs/read.jsp */
	$("button#volumnDownBtn").click(function(){
		
		let beforeVol = $("input#orderVolumn").val();
		if(beforeVol>1) {
			$("input#orderVolumn").val(beforeVol-1);
		} else {
			alert("주문수량은 1개 이상만 가능합니다.");
		}
		
	});
	$("button#volumnUpBtn").click(function(){
		
		let beforeVol = $("input#orderVolumn").val();
		beforeVol = parseInt(beforeVol);
		let stockVolumn = $("input[type=hidden]#stockVolumn").val();
		if(beforeVol<stockVolumn) {
			$("input#orderVolumn").val(beforeVol+1);			
		} else {
			alert(stockVolumn+"개까지만 주문가능합니다.");
		}
		
	});
	$("input#orderVolumn").change(function(){
		let orderVolumn = $("input#orderVolumn").val();
		orderVolumn = parseInt(orderVolumn);
		let stockVolumn = $("input[type=hidden]#stockVolumn").val();
		stockVolumn = parseInt(stockVolumn);
		if (orderVolumn < 1) {
			alert("1개 이상만 주문가능합니다.");
			$("input#orderVolumn").val(1);	
		} else if(orderVolumn>stockVolumn) {
			alert(stockVolumn+"개까지만 주문가능합니다.");
			$("input#orderVolumn").val(stockVolumn);			
		}
	})
	/* 상품 게시글에서 주문 수량 증감 버튼 끝 /bbs/read.jsp */
	
	/* 상품 게시글 삭제버튼 시작 /bbs/read.jsp */
	$("button#delBtn").click(function(){
		
		let chkTF = confirm("게시글을 삭제하시겠습니까?");
		
		if (chkTF) {
			let nowPage = $("input#nowPage").val().trim();
			let num = $("input#num").val().trim();

		    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
			let p5 = $("#orderBy").val();
		    let p6 = $("#typeSearch").val();
			
			let url = "/product/prodDelProc.jsp?";
				url += "num="+num+"&nowPage="+nowPage;

				url += "&keyWord="+p4;
				url += "&orderBy="+p5;
				url += "&typeSearch="+p6;
			location.href=url;
		} else {
			alert("취소하셨습니다.");	
		}
		
	});
	/* 상품 게시글 삭제버튼 끝 /bbs/read.jsp */
	
	/* 상품 게시글 내용보기페이지에서 수정버튼 시작 /bbs/read.jsp */
	$("button#modBtn").click(function(){
	
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
				
	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		let p5 = $("#orderBy").val();
		let p6 = $("#typeSearch").val();
		
		let url = "/product/prodMod.jsp?";
			url += "num="+num;
			url += "&nowPage="+nowPage;
	     	url += "&keyWord="+p4;
			url += "&orderBy="+p5;
			url += "&typeSearch="+p6; 
		location.href=url;
	});
	
	/* 상품 게시글 내용보기페이지에서 수정버튼 끝 /bbs/read.jsp */
	$("button#contentBtn").click(function(){
		$("div#content").css({
			"display": "block"
		});
		$("div#review").css({
			"display": "none"
		});
	});
	
	$("button#reviewBtn").click(function(){
		$("div#review").css({
			"display": "block"
		});
		$("div#content").css({
			"display": "none"
		});
	});
	
	/* 상품 게시글 상품설명/리뷰 전환 버튼 시작*/
	
	
	/* 상품 게시글 상품설명/리뷰 전환 버튼 끝*/
	
	/* 장바구니에 넣기 버튼 시작 */
	$("button.cartInsertBtn").click(function(){
		let uId = $("input#uId").val();
		if(uId=="null" || uId=="" || uId ==null) {
			alert("로그인 후 이용 가능합니다.");
			location.href ="/Member/Login.jsp";
		} else {

			let pNum = $("input#num").val().trim();
			let pVolumn = $("input#orderVolumn").val().trim();
		    
			let url = "/cart/cartInsertProc.jsp?";
				url += "pNum="+pNum+"&pVolumn="+pVolumn+"&uId="+uId;
			$(this).siblings("iframe.cartInsertIfr").attr("src", url);
		}
	});

	/* 장바구니에 넣기 버튼 끝 */
	
	/* 위시리스트에 넣기 버튼 시작 */
	$("button.wishInsertBtn").click(function(){
		let uId = $("input#uId").val();
		if(uId=="null" || uId=="" || uId ==null) {
			alert("로그인 후 이용 가능합니다.");
			location.href="/Member/Login.jsp";
		} else {

			let pNum = $("input#num").val().trim();
		    
			let url = "/wishlist/wishInsertProc.jsp?";
				url += "pNum="+pNum+"&uId="+uId;
			$(this).siblings("iframe.wishInsertIfr").attr("src", url);
		}
	});

	/* 위시리스트에 넣기 버튼 끝 */
	
	
	/* 구매 버튼 시작 */
	$("button.directOrderBtn").click(function(){
		let uId = $("input#uId").val();
		if(uId=="null" || uId=="" || uId ==null) {
			alert("로그인 후 이용 가능합니다.");
			location.href="/Member/Login.jsp";
		} else {
			let pVolumn = $("input#orderVolumn").val();
			let pNum = $("input#num").val();
			url = "/order/order.jsp?pNum="+pNum;
			url+= "&pVolumn="+pVolumn;
			url+= "&flag=o";
			location.href = url;		
		}
	});
	/* 구매 버튼 끝 */
	
	
});

/* 상세내용 보기 페이지 이동 시작 /bbs/list.jsp => read.jsp */
	function read(p1, p2) {

	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		let p5 = $("#orderBy").val();
		let p6 = $("#typeSearch").val();
		
		let param = "/product/prodRead.jsp?num="+p1;
		     param += "&nowPage="+p2;

		     param += "&keyWord="+p4;
			 param += "&orderBy="+p5;
			 param += "&typeSearch="+p6;
		location.href=param;
	}		
/* 상세내용 보기 페이지 이동 끝 /bbs/list.jsp => read.jsp  */

/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동
	
    let p4 = $("#pKeyWord").val().trim();  // p3 : keyField

	let p5 = $("#orderBy").val();
	let p6 = $("#typeSearch").val();
	
	let param = "/product/prodList.jsp?nowPage="+p1;	    
	     param += "&keyWord="+p4;
		 param += "&orderBy="+p5; 
		param += "&typeSearch="+p6;
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */
 

/* 리스트페이지 페이징 블럭이동 시작 /bbs/list.jsp */
function moveLeftBlock(p1, p2) {    // 이전 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2);
	
    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let p5 = $("#orderBy").val();
	let p6 = $("#typeSearch").val();	
	let param = "/product/prodList.jsp?nowPage="+(pagePerBlock*blockNum);
	     param += "&keyWord="+p4; 
		 param += "&orderBy="+p5; 
		param += "&typeSearch="+p6;
	location.href=param;
}

function moveRightBlock(p1, p2) {    // 다음 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2);
	

    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
	let p5 = $("#orderBy").val();
	let p6 = $("#typeSearch").val();	
	let param = "/product/prodList.jsp?nowPage="+(pagePerBlock*(blockNum-1)+1);
	     param += "&keyWord="+p4;
		 param += "&orderBy="+p5;
		 param += "&typeSearch="+p6;
	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs/list.jsp */

