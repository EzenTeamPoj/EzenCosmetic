package pack_Order;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import pack_DBCP.DBConnectionMgr;
import pack_ProdBoard.CartBean;
import pack_ProdBoard.ProdBoardMgr;
import pack_ProdBoard.WishlistBean;

public class OrderMgr {
	
	private DBConnectionMgr objPool;

	Connection 				objConn;
	PreparedStatement 	objPstmt;
	Statement				 	objStmt;
	ResultSet 					objRS;
	
	public OrderMgr() {
		try {
			objPool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	
	
	public int insertUOrder(UOrderBean objBean) {

		String sql = null;
		int orderNum = 0;

		try {
			objConn = objPool.getConnection();

			sql = "insert into uOrder (";
			sql += "orderId, delivAdd, goodsPay, delivFee, totalPay, payWay, ordetStatus, orderTM)";
			sql += " values (?, ?, ?, ?, ?, ?, '주문완료', now())";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, objBean.getOrderId());
			objPstmt.setString(2, objBean.getDelivAdd());
			objPstmt.setInt(3, objBean.getGoodsPay());
			objPstmt.setInt(4, objBean.getDelivFee());
			objPstmt.setInt(5, objBean.getTotalPay());
			objPstmt.setString(6, objBean.getPayWay());
			int exeCnt = objPstmt.executeUpdate();
			
			if(exeCnt == 1) {
				sql = "select max(num) from uOrder";
				objPstmt = objConn.prepareStatement(sql);
				objRS = objPstmt.executeQuery();
				if(objRS.next()) {
					orderNum = objRS.getInt(1);
				}
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return orderNum;

	}
	
	
	
	public int insertOrderGoods(OrderGoodsBean objBean) {

		String sql = null;
		int exeCnt = 0;

		try {
			objConn = objPool.getConnection();

			sql = "insert into orderGoods (";
			sql += "orderNum, pNum, pVolumn)";
			sql += " values (?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, objBean.getOrderNum());
			objPstmt.setInt(2, objBean.getpNum());
			objPstmt.setInt(3, objBean.getpVolumn());
			exeCnt = objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return exeCnt;

	}
	
	
	
	public int insertMulOrderGoods(int orderNum, String orderId, String [] cartNum) {

		String sql = null;
		int exeCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			
			ProdBoardMgr objProd = new ProdBoardMgr();
			Vector<CartBean> objList =objProd.orderCartList(orderId, cartNum);
			
			
			sql = "insert into orderGoods (";
			sql += "orderNum, pNum, pVolumn)";
			sql += " values (?, ?, ?)";
			for (int i = 0 ; i < objList.size(); i++) {
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, orderNum);
				CartBean objCart = objList.get(i);
				objPstmt.setInt(2, objCart.getpNum());
				objPstmt.setInt(3, objCart.getpVolumn());
				exeCnt += objPstmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return exeCnt;

	}
	
	
	
	/*///////// 주문내역 출력 시작 //////////*/
	public Vector<UOrderBean> getOrderList(int start, int end, String uId) {

		Vector<UOrderBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "select num, delivAdd, goodsPay, delivFee, totalPay, payWay, ordetStatus, orderTM ";
			sql	+= " from uOrder where orderId = ? order by num desc limit ?, ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objPstmt.setInt(2, start);
			objPstmt.setInt(3, end);
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				UOrderBean bean = new UOrderBean();
				bean.setNum(objRS.getInt(1));
				bean.setDelivAdd(objRS.getString(2));
				bean.setGoodsPay(objRS.getInt(3));
				bean.setDelivFee(objRS.getInt(4));
				bean.setTotalPay(objRS.getInt(5));
				bean.setPayWay(objRS.getString(6));
				bean.setOrdetStatus(objRS.getString(7));
				bean.setOrderTM(objRS.getString(8));
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}
	
	/* 총 게시물 수(/product/prodList.jsp) 시작  */
	public int getTotalOrderList(String uId)  {
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			
			sql = "select count(*) from uOrder where orderId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);

			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				totalCnt = objRS.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return totalCnt;
	}
	/* 총 게시물 수(/product/prodList.jsp) 끝  */
	
	/* 주문번호에 해당하는 주문상품 출력 시작  */
	public Vector<OrderGoodsBean> selectOrderGoods(int orderNum) {

		String sql = null;
		Vector<OrderGoodsBean> vList = new Vector<>();
		try {
			objConn = objPool.getConnection();

			sql = "select pNum, pVolumn, pName from orderGoods inner join goodsTbl ";
			sql += " on orderGoods.pNum = goodsTbl.num where orderNum = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, orderNum);
			objRS = objPstmt.executeQuery();
			
			OrderGoodsBean objBean = null;
			while(objRS.next()) {
				objBean = new OrderGoodsBean();
				objBean.setpNum(objRS.getInt(1));
				objBean.setpVolumn(objRS.getInt(2));
				objBean.setpName(objRS.getString(3));
				vList.add(objBean);
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return vList;

	}
	
	/* 주문번호에 해당하는 주문상품 출력 끝  */
	
	/*///// 주문내역 출력시작 끝 ///////*/
	
	
	/* 리뷰 작성을 위한 주문 확인 시작*/
	

	public int getTotalOrderList(String uId, int pNum)  {
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			
			sql = "select count(*) from uOrder inner join orderGoods ";
			sql += " on uOrder.num = orderGoods.orderNum where orderId = ? and pNum = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objPstmt.setInt(2, pNum);

			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				totalCnt = objRS.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return totalCnt;
	}
	
	
	/* 리뷰 작성을 위한 주문 확인 끝*/
	
}
