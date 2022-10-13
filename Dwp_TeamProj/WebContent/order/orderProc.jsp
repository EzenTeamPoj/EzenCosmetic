<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="objOrder" class="pack_Order.OrderMgr"/>
<jsp:useBean id="objOrderBean" class="pack_Order.UOrderBean"/>
<jsp:setProperty name="objOrderBean" property="*"/>
<jsp:useBean id="objGoodsBean" class="pack_Order.OrderGoodsBean"/>
<% 
 	int orderNum = objOrder.insertUOrder(objOrderBean);
	String flag = request.getParameter("flag");
	String [] cartNum = (String[])session.getAttribute("cartNum_Session");
	
	
	int rtnCnt = 0;
	
	if (flag.equals("o")) {
		String pNumParam = request.getParameter("pNum");
		String pVolumnParam = request.getParameter("pVolumn");
		int pNum = Integer.parseInt(pNumParam);
		int pVolumn = Integer.parseInt(pVolumnParam);	
		
		objGoodsBean.setOrderNum(orderNum);
		objGoodsBean.setpNum(pNum);
		objGoodsBean.setpVolumn(pVolumn);
		
		rtnCnt =objOrder.insertOrderGoods(objGoodsBean);
	} else if (flag.equals("m")) {
		String orderId = objOrderBean.getOrderId();
		rtnCnt = objOrder.insertMulOrderGoods(orderNum, orderId, cartNum);
	}
	
	if (rtnCnt > 0) { %>
		alert("구매되었습니다.");
		
<% 	} else { %>
	
	alert("구매과정에서 오류가 발생했습니다. 다시 시도해주세요.");

<% }		
	response.sendRedirect("/order/orderList.jsp");
%>	