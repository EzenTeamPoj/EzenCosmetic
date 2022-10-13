$(function(){

	
	
	 // 정방향 전체 체크 적용 시작 //
		
    $("input#chkAll").click(function(){
	  let chkToF =  $(this).prop("checked");
	  $("input.chkOne").prop("checked",chkToF);
	});
    // 정방향 전체 체크 적용 끝 //
	
	// 역방향 전체 체크 적용 //
	$("input.chkOne").click(function(){
		
		let boolChk = false;
		let prodCnt = 0;				
		let chkCnt = 0;
		$("input[type=checkbox].chkOne").each(function () {
			prodCnt++;
     		if($(this).prop("checked")) {
				chkCnt++;
			}
		});	
		
		
		if (prodCnt == chkCnt) {
			boolChk = true;    // 3개의 약관 모두 체크 되었을 때 실행됨.
		}
		
		$("input#chkAll").prop("checked", boolChk);
	});
	
	/* 위시리스트 전체삭제 - 선택삭제 버튼 이름 바뀜 시작*/
	$("input#chkAll, input.chkOne").change(function(){
	  let chkToF =  $("input#chkAll").prop("checked");
	  if(chkToF) {
		$("button#multiDelBtn").text("전체삭제");
	   } else {
		$("button#multiDelBtn").text("선택삭제");
	   }
	});
	
	/* 위시리스트 전체삭제 - 선택삭제 버튼 이름 바뀜 끝*/
	
	
	
	
	/* 위시리스트 다중 삭제 시작*/
	$("button#multiDelBtn").click(function(){
		let delToF = confirm("정말로 삭제하시겠습니까?");
		if (delToF) {
			$("input.chkOne:checked").each(function () {
		     	$(this).parents("tr").find("input.delNum").attr("name", "num");
			});	
			$("form#multiDelFrm").submit();	
		} else {
			alert("취소하셨습니다.");
		}
	});
	/* 위시리스트 다중 삭제 끝*/
	
	/* 위시리스트 개별 삭제 시작*/
	$("button.oneDelBtn").click(function(){
		let delToF = confirm("정말로 삭제하시겠습니까?");
		if (delToF) {
			let num = $(this).parents("tr").find("input.delNum").val();
			location.href="/wishlist/wishOneDelProc.jsp?num="+num;
		} else {
			alert("취소하셨습니다.");
		}
	});
	/* 위시리스트 개별 삭제 시작*/
	
	
	/* 장바구니 다중 넣기 시작*/
	$("button.cartInsertBtn").click(function(){


		$("input.chkOne:checked").each(function () {
		     $(this).parents("tr").find("input.pNum").attr("name", "pNum");
		});	
		$("form#multiDelFrm").submit();	
		
	});
	/* 장바구니 다중 넣기 끝*/
});


/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동

	let param = "/wishlist/wishlist.jsp?nowPage="+p1;	    
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /bbs/list.jsp */
function moveLeftBlock(p1, p2) {    // 이전 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2);
	
	let param = "/wishlist/wishlist.jsp?nowPage="+(pagePerBlock*blockNum);
	location.href=param;
}

function moveRightBlock(p1, p2) {    // 다음 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2)
	
	let param = "/wishlist/wishlist.jsp?nowPage="+(pagePerBlock*(blockNum-1)+1);
	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs/list.jsp */





