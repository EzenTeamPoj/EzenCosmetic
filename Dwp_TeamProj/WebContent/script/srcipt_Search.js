$(function(){
	
	/*inputCustom 시작*/
/*	$("input.input").mouseout(function(){
		$(this).val("").blur();
	});
   /*inputCustom 끝*/


	/* 검색 버튼 시작 */
	$("i.fa-search").click(function(){
	/*	let nowPage = $("input#nowPage").val().trim(); */
					
		let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
		let p6 = $("#typeSearch").val().trim();
		
		let param = "/product/prodList.jsp?";
			param += "&keyWord="+p4;
			param += "&typeSearch="+p6;
			window.parent.location.href=param; 
	});
	
	
	$("input.input").keypress(function(e){
		if(e.keyCode == 13) {
			let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
			let p6 = $("#typeSearch").val().trim();
			
			let param = "/product/prodList.jsp?";
				param += "&keyWord="+p4;
				param += "&typeSearch="+p6;
				window.parent.location.href=param; 
		}
	});
	

	
	/* 검색 버튼 끝 */
  
});