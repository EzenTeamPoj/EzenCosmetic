<%@page import="pack_ProdBoard.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page import="pack_ProdBoard.ProdBoardMgr"%>
<%@page import="pack_Member.MemberBean"%>
<%@page import="pack_ProdBoard.ProdBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<jsp:useBean id="pMgr" class="pack_ProdBoard.ProdBoardMgr" />
<%
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	int pNum = 0;
	String pName = "";
	int pVolumn = 0;
	int sellPrice=0;
	int  goodsPay = 0;
	int delivFee = 3000;				//#delivFee 배송비	
	int totalPay = 0;
	String [] cartNum = null;
	Vector<CartBean> objList = null;
	String flag = request.getParameter("flag");
	
	
	if (flag.equals("o")) {
		pNum = Integer.parseInt(request.getParameter("pNum"));
		pVolumn = Integer.parseInt(request.getParameter("pVolumn"));
		ProdBoardBean objProd = pMgr.getBoard(pNum);
		pName = objProd.getpName();
		sellPrice = objProd.getSellPrice();
		
		goodsPay = sellPrice*pVolumn;  //#goodsPay 총상품가격
		if(goodsPay >= 20000) {
			delivFee = 0;
		}
	
	 	totalPay = goodsPay + delivFee; // totalPay 총결제금액
	} else if (flag.equals("m")) {
		goodsPay = Integer.parseInt(request.getParameter("goodsPay"));
		delivFee = Integer.parseInt(request.getParameter("delivFee"));
		totalPay = Integer.parseInt(request.getParameter("totalPay"));
		
		cartNum = request.getParameterValues("cartNum");
		ProdBoardMgr objProd = new ProdBoardMgr();
		objList =objProd.orderCartList(uId_Session, cartNum);
		
		session.setAttribute("cartNum_Session", cartNum);
	}
	
	MemberBean objMB  = mMgr.modifyMember(uId_Session);
	String uName = objMB.getuName();
	String Addr = objMB.getuAddr();
	String postNum = Addr.substring(1,6);
	String remainAddr = Addr.substring(7);
	
	
	

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/order_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	    <script src ="/script/ApiScript.js"></script>
		<script src="/script/script_Order.js"></script>
	</head>
	<body>
	<header>
	    <!--  헤더템플릿 시작, iframe으로 변경 -->
			<iframe src="/indd/header.jsp" scrolling="no" width="100%" frameborder=0 id="headerIfm"></iframe>
	    <!--  헤더템플릿 끝 -->   
  		</header>
		<div id="wrap" class="orderWrap">
			<h1>주문/결제</h1>
			<hr>
			<form action="/order/orderProc.jsp" id="orderFrm">
			
				<table>
					<tbody>
						<tr>
							<th>이름</th>
							<td><%=uName %></td>
						</tr>
						<tr>
		     				<th>배송지 우편번호</th>
		     				<td>
						     <input type="text" id="postcode" placeholder="우편번호" class="req" value="<%=postNum%>">
					         <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" ><br>
						    </td>
				       </tr>
				       <tr>
				        	<th >배송지 주소</th>
					     	<td>
				         		<input type="text" id="address" placeholder="주소" class="refList" value="<%= remainAddr%>"><br>
				         	</td>
			          </tr>
			          <tr>
					         <th>상세주소</th>
					         <td>
						         <input type="text" id="detailAddress" placeholder="상세주소"
						         class="refList">
					         </td>
			          </tr>
			          <tr>
					         <th>참고항목</th>
					         <td>
						         <input type="text" id="extraAddress" placeholder="참고항목"
						         class="refList">
						         <input type="hidden" name="delivAdd" id="uAddr" />
					         </td>
			          </tr>
			          <tr>
			          	<th>상품명/개수</th>
			          	<td>&nbsp;</td>
			          	<!-- 수정함!!!!!!!!!!!!!!!!!!!!!!!!!!!  -->
			          </tr>
			     <%   if(flag.equals("o")) { %>
			     		<tr>
			     			<th>&nbsp;</th>
							<td class="dFlex center">
								<div>
									<%=pName %>
									<input type="hidden" name="pName" value="<%=pName %>">
									<input type="hidden" name="pNum" value="<%=pNum %>">
								</div>
								<div>
									<%=pVolumn %>개
									<input type="hidden" name="pVolumn" value="<%=pVolumn %>">
								</div>
							</td>
						</tr>
				
			     <% 
			     }  else if(flag.equals("m")) {
			          	for (int i = 0 ; i < objList.size(); i++) {
			        	  CartBean objCart = objList.get(i);
			        	  pName = objCart.getpName();
			        	  pVolumn = objCart.getpVolumn();
			      %>
						<tr>
			     			<th>&nbsp;</th>
							<td class="dFlex center">
								<div>
									<%=pName %>
									<input type="hidden" value="<%=pName %>">
								</div>
								<div>
									<%=pVolumn %>개
									<input type="hidden" value="<%=pVolumn %>">
								</div>
							</td>
						</tr>
					<% } %>	
				<% } %>	
						<tr>
							<th>총상품가격</th>
							<td>
								<%=goodsPay %>
								<input type="hidden" name="goodsPay" value="<%=goodsPay %>">
							</td>
						</tr>
						<tr>
							<th>배송비</th>
							<td>
								<%=delivFee %>
								<input type="hidden" name="delivFee" value="<%=delivFee %>">
							</td>
						</tr>
						<tr>
							<th>총결제금액</th>
							<td>
								<%= totalPay %>
								<input type="hidden" name="totalPay" value="<%=totalPay %>">
							</td>
						</tr>
						<tr>
							<th>결제수단</th>
							<td>
								<label>
									<span>계좌이체</span>
									<input type="radio" name="payWay" class="payWay" value="계좌이체">
								</label>
								<label>
									<span>신용/체크카드</span>
									<input type="radio" name="payWay" class="payWay" value="신용/체크카드">
								</label>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<input type="hidden" name="orderId" value="<%=uId_Session %>">
								<input type="hidden" name="flag" value="<%=flag%>">
								<button id="orderBtn">결제하기</button>
							</td>
						</tr>
					</tfoot>
				</table>
			</form>
		</div>
		<!-- div#wrap -->
			<iframe src="/indd/footer.jsp" scrolling="no" width="100%" frameborder=0 id="footerIfm"></iframe>
	</body>
</html>
