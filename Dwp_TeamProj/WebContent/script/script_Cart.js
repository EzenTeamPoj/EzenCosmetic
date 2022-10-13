$(function(){
	



	/* 상품 게시글에서 주문 수량 증감 버튼 시작 /bbs/read.jsp */
	$("button.volumnDownBtn").click(function(){
		
		let orderVolumn = $(this).next("input.orderVolumn").val();
		if(orderVolumn>1) {
			$(this).next("input.orderVolumn").val(orderVolumn-1);
			orderVolumn = orderVolumn-1;
		} else {
			alert("주문수량은 1개 이상만 가능합니다.");
		}
		
		let sellPrice = $(this).parents("tr").find("input.sellPrice").val();
		$(this).parents("tr").find("input.prodPay").val(orderVolumn*sellPrice);
		$(this).parent("td").next("td.prodPay").text((orderVolumn*sellPrice).toLocaleString()+"원");
		
		let num = $(this).parents("tr").find("input.num").val().trim();
		let pVolumn = orderVolumn;
		    
		let url = "/cart/cartModProc.jsp?";
			url += "num="+num+"&pVolumn="+pVolumn;
		$("iframe.cartModIfr").attr("src", url);
		
	});
	$("button.volumnUpBtn").click(function(){
		
		let orderVolumn = $(this).prev("input.orderVolumn").val();
		orderVolumn = parseInt(orderVolumn);
		let stockVolumn = $(this).next("input[type=hidden].stockVolumn").val();
		if(orderVolumn<stockVolumn) {
			$(this).prev("input.orderVolumn").val(orderVolumn+1);
			orderVolumn = orderVolumn+1;			
		} else {
			alert(stockVolumn+"개까지만 주문가능합니다.");
		}
		
		let sellPrice = $(this).parents("tr").find("input.sellPrice").val();
		$(this).parents("tr").find("input.prodPay").val(orderVolumn*sellPrice);
		$(this).parent("td").next("td.prodPay").text((orderVolumn*sellPrice).toLocaleString()+"원");
		
		let num = $(this).parents("tr").find("input.num").val().trim();
		let pVolumn = orderVolumn;
		    
		let url = "/cart/cartModProc.jsp?";
			url += "num="+num+"&pVolumn="+pVolumn;
		$("iframe.cartModIfr").attr("src", url);
		
	});
	$("input.orderVolumn").change(function(){
		let orderVolumn = $(this).val();
		orderVolumn = parseInt(orderVolumn);
		let stockVolumn = $(this).siblings("input[type=hidden].stockVolumn").val();
		stockVolumn = parseInt(stockVolumn);
		if (orderVolumn < 1) {
			alert("1개 이상만 주문가능합니다.");
			$(this).val(1);
			orderVolumn = 1;
		} else if(orderVolumn>stockVolumn) {
			alert(stockVolumn+"개까지만 주문가능합니다.");
			$(this).val(stockVolumn);		
			orderVolumn = stockVolumn;
		}
		
		let sellPrice = $(this).parents("tr").find("input.sellPrice").val();
		$(this).parents("tr").find("input.prodPay").val(orderVolumn*sellPrice);
		$(this).parent("td").next("td.prodPay").text((orderVolumn*sellPrice).toLocaleString()+"원");
		
		let num = $(this).parents("tr").find("input.num").val().trim();
		let pVolumn = orderVolumn;
		    
		let url = "/cart/cartModProc.jsp?";
			url += "num="+num+"&pVolumn="+pVolumn;
		$("iframe.cartModIfr").attr("src", url);
		
	})
	/* 상품 게시글에서 주문 수량 증감 버튼 끝 /bbs/read.jsp */
	
	
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
		
		// .eq(인덱스번호)  => 형제요소들의 인덱스번호에 해당하는 대상을 선택, eq = equal
		//let str = "chk0 : " + chk0 + "\nchk1 : " + chk1 + "\nchk2 : " + chk2;
		//alert(str);
		
		if (prodCnt == chkCnt) {
			boolChk = true;    // 3개의 약관 모두 체크 되었을 때 실행됨.
		}
		
		$("input#chkAll").prop("checked", boolChk);
	});
	
	/* 전체삭제 - 선택삭제 버튼 이름 바뀜 시작*/
	$("input#chkAll, input.chkOne").change(function(){
	  let chkToF =  $("input#chkAll").prop("checked");
	  if(chkToF) {
		$("button#multiDelBtn").text("전체삭제");
	   } else {
		$("button#multiDelBtn").text("선택삭제");
	   }
	});
	
	/* 전체삭제 - 선택삭제 버튼 이름 바뀜 끝*/
	
	
	/* 총 상품가격 계산 시작 */
	$("input.chkOne, input#chkAll, input.orderVolumn, button.volumnDownBtn, button.volumnUpBtn").on("change click", function(){
		let boolChk = false;
		$("input.chkOne:checked").each(function () {
     		boolChk = true;
		});	
		
		if (boolChk) {
			let totalProdPrice = 0;
			$("input.chkOne:checked").each(function () {
	     		prodPay = $(this).next("input.prodPay").val();
				totalProdPrice += parseInt(prodPay)
			});	
			$("input.totalProdPrice").val(totalProdPrice)
			$("span.totalProdPrice").text(totalProdPrice.toLocaleString()+"원");
			
			if(totalProdPrice >= 20000 || totalProdPrice == 0) {
				$("input.totaldelivFee").val(0);
				$("span.totaldelivFee").text("0원");
				
				$("input.totalPayment").val(totalProdPrice);
				$("span.totalPayment").text(totalProdPrice.toLocaleString()+"원");
			} else {
				$("input.totaldelivFee").val(3000);
				$("span.totaldelivFee").text("3,000원");
				
				$("input.totalPayment").val(totalProdPrice+3000);
				$("span.totalPayment").text((totalProdPrice+3000).toLocaleString()+"원");
			}
			
		} else {
			$("input.totalProdPrice").val(0)
			$("span.totalProdPrice").text("0원");
			$("input.totaldelivFee").val(0)
			$("span.totaldelivFee").text("0원");
			$("input.totalPayment").val(0)
			$("span.totalPayment").text("0원");
		}
	});
	
	/* 총 상품가격 계산 끝 */	
	
	
	/* 장바구니 다중 삭제 시작*/
	$("button#multiDelBtn").click(function(){
		let delToF = confirm("정말로 삭제하시겠습니까?");
		if (delToF) {
			$("input.chkOne:checked").each(function () {
		     	$(this).parents("tr").find("input.num").attr("name", "num");
			});	
			$("form#multiDelFrm").submit();	
		} else {
			alert("취소하셨습니다.");
		}
	});
	/* 장바구니 다중 삭제 끝*/
	
	/* 장바구니 개별 삭제 시작*/
	$("button.oneDelBtn").click(function(){
		let delToF = confirm("정말로 삭제하시겠습니까?");
		if (delToF) {
			let num = $(this).parents("tr").find("input.num").val();
			location.href="/cart/cartOneDelProc.jsp?num="+num;
		} else {
			alert("취소하셨습니다.");
		}
	});
	/* 장바구니 개별 삭제 시작*/
	
	/* 장바구니에서 구매하기로 넘어가기 시작*/
	$("button#orderMoveBtn").click(function(){
		$("input.chkOne:checked").each(function () {
		     $(this).parents("tr").find("input.cartNumOrder").attr("name", "cartNum");
		});	
	});
	
	/* 장바구니에서 구매하기로 넘어가기 끝*/

});




