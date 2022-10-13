$(function(){
    
	 // 주소 병합 소스만들기 시작
	$("button#orderBtn").click(function(){
      let postcode = $("input#postcode").val().trim();
      let address= $("input#address").val().trim();
      let uAddr=  "("+postcode+")"+ address;
      $("input#uAddr").val(uAddr);

    // 주소 병합 소스만들기 끝
	});
	
	$("form#orderFrm").submit(function(){
		oAddr = $("input#uAddr").val();
		if(oAddr=="" || oAddr == null) {
			alert("배송지를 입력해주세요");
			return false;
		}
		let chkNum = $("input[type=radio].payWay:checked").length;
		if(chkNum==0) {
			alert("결제수단을 선택해주세요");
			return false;
		}
	});
	






});
/* 리스트페이지 페이징 시작 /bbs/list.jsp */
function movePage(p1) {    // 페이지 이동

	let param = "/order/orderList.jsp?nowPage="+p1;	    
	location.href= param;

}
/* 리스트페이지 페이징 끝 /bbs/list.jsp */


/* 리스트페이지 페이징 블럭이동 시작 /bbs/list.jsp */
function moveLeftBlock(p1, p2) {    // 이전 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2);
	
	let param = "/order/orderList.jsp?nowPage="+(pagePerBlock*blockNum);
	location.href=param;
}

function moveRightBlock(p1, p2) {    // 다음 블럭 이동

	let blockNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	//alert("p1 : " + p1 + "\np2 : " + p2)
	
	let param = "/order/orderList.jsp?nowPage="+(pagePerBlock*(blockNum-1)+1);
	location.href=param;
}
/* 리스트페이지 페이징 블럭이동 끝 /bbs/list.jsp */