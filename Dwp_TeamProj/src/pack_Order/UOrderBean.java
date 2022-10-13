package pack_Order;

public class UOrderBean {
	int num;    //num 주문번호
	String orderId;
	String delivAdd;
	int goodsPay;
	int delivFee;
	int totalPay;
	String payWay;
	String ordetStatus;
	String orderTM;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getDelivAdd() {
		return delivAdd;
	}
	public void setDelivAdd(String delivAdd) {
		this.delivAdd = delivAdd;
	}
	public int getGoodsPay() {
		return goodsPay;
	}
	public void setGoodsPay(int goodsPay) {
		this.goodsPay = goodsPay;
	}
	public int getDelivFee() {
		return delivFee;
	}
	public void setDelivFee(int delivFee) {
		this.delivFee = delivFee;
	}
	public int getTotalPay() {
		return totalPay;
	}
	public void setTotalPay(int totalPay) {
		this.totalPay = totalPay;
	}
	public String getPayWay() {
		return payWay;
	}
	public void setPayWay(String payWay) {
		this.payWay = payWay;
	}
	public String getOrdetStatus() {
		return ordetStatus;
	}
	public void setOrdetStatus(String ordetStatus) {
		this.ordetStatus = ordetStatus;
	}
	public String getOrderTM() {
		return orderTM;
	}
	public void setOrderTM(String orderTM) {
		this.orderTM = orderTM;
	}
	
}
