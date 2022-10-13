 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<%@ page import="pack_ProdBoard.ProdBoardBean" %>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num"));
String nowPage = request.getParameter("nowPage");

//검색어 수신 시작
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
//검색어 수신 끝

ProdBoardBean bean = (ProdBoardBean)session.getAttribute("bean");
String pName = bean.getpName();
String pType=bean.getpType();
int stockVolumn = bean.getStockVolumn();
int salesVolumn = bean.getSalesVolumn();
int oriPrice = bean.getOriPrice();
int sellPrice = bean.getSellPrice();
String [] sellLabel = bean.getSellLabel();
String [] sellLabelDisplay = new String [4];
for(int j =0; j <sellLabel.length; j ++) {
	if(sellLabel[j].equals("1")) {
		sellLabelDisplay[j] = "checked";
	} else if(sellLabel[j].equals("0")){
		sellLabelDisplay[j] = "";
	}
}
String content = bean.getContent();
%>   
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/product_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_Product.js"></script>
	</head>
	<body>
	 	<header>
	    	<!--  헤더템플릿 시작, iframe으로 변경 -->
			<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    	<!--  헤더템플릿 끝 -->   
  	  	</header>
		<div id="wrap">
			<main id="main">
				<div class="bbsWrite">
					<h2>상품 수정</h2>
					<form action="/product/prodModProc.jsp" method="get">
						<table id="prodPostTbl">
							<tbody>
								<tr>
									<th class="req">상품명</th>
									<td>
										<input type="text" name="pName" id="pName" value="<%=pName%>">
									</td>
								</tr>
								<tr>
									<th class="req">상품종류</th>
									<td>
										<select name="pType" id="pType">
											<option value="">선택해주세요</option>     
											<!-- 선택해주세요를 선택하면 전송 못하도록  JavaScript로 구현하기-->
											<option <%if(pType.equals("스킨케어")) out.print("selected"); %>>스킨케어</option>
											<option <%if(pType.equals("로션")) out.print("selected"); %>>로션</option>
											<option <%if(pType.equals("핸드크림")) out.print("selected"); %>>핸드크림</option>
											<option <%if(pType.equals("기타")) out.print("selected"); %>>기타</option>
										</select>
									</td>
								</tr>
								<tr>
									<th class="req">재고</th>
									<td>
										<input type="number" name="stockVolumn" id="stockVolumn" value="<%=stockVolumn%>">
									</td>
								</tr>
								<tr>
									<th>판매량</th>
									<td>
										<input type="number" name="salesVolumn" id="salesVolumn" value="<%=salesVolumn%>">
									</td>
								</tr>
								<tr>
									<th class="req">가격</th>
									<td>
										<label>
											원래 가격
											<input type="number" name="oriPrice" id="oriPrice" value="<%=oriPrice%>">
										</label>
										<label>
											판매 가격
											<input type="number" name="sellPrice" id="sellPrice" value="<%=sellPrice%>">
										</label>
									</td>
								</tr>
								<tr>
									<th class="req">상품라벨</th>
									<td>
										<label>
											베스트상품
											<input type="checkbox" name="sellLabel" class="sellLabel" value="BEST" <%=sellLabelDisplay[0] %>>	
										</label>
										<label>
											신상품
											<input type="checkbox" name="sellLabel" class="sellLabel" value="NEW" <%=sellLabelDisplay[1] %>>	
										</label>
										<label>
											할인상품
											<input type="checkbox" name="sellLabel" class="sellLabel" value="SALE" <%=sellLabelDisplay[2] %>>	
										</label>
										<label>
											해당없음
											<input type="checkbox" name="sellLabel" class="sellLabel" value="NONE" <%=sellLabelDisplay[3] %>>	  
											<!--해당없음 누르면 다른 것을 중복 선택 못하도록 JavaScript로 구현하기 -->
										</label>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<textarea name="content" id="content" cols="80" rows="10"><%=content %></textarea>
									</td>
								</tr>
		<!-- 						<tr>
									<th>이미지</th>
									<td>
										<input type="file" name="imgFile" id="imgFile">
									</td>
								</tr> -->
							</tbody>
							<tfoot>
								<tr>
									<td>
										<button type="submit">전송</button>
									</td>
								</tr>
							</tfoot>
						</table>
							<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
							<input type="hidden" name="num" value="<%=num%>" id="num">
							
							<!-- 검색어전송 시작 -->
							<input type="hidden" name="keyField" id="keyField" value="<%=keyField%>">
							<input type="hidden" name="keyWord" id="keyWord" value="<%=keyWord%>">
							<!-- 검색어전송 끝 -->
					</form>			
				</div>
			</main>
			
		</div>
		<!--div#wrap  -->
		<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	</body>
</html>