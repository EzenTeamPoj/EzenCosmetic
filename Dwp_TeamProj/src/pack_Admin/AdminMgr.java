package pack_Admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import pack_DBCP.DBConnectionMgr;

public class AdminMgr {
	
	Connection				objConn 		=		null;
	Statement					objStmt			=		null;	
	ResultSet					objRS			=		null;  	
	PreparedStatement 	objPstmt 		=		null; 
	DBConnectionMgr 		objPool 		= 		null;


	public static void main(String[] args) {
		new AdminMgr( );
	}

	public boolean insertAdministrator(AdminBean bean) {
		
		boolean flag = false;
		
		
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "insert into adminList (aId, aPw, aName, aEmail, aPhone, joinTM) values(?, ?, ?, ?, ?,now() ) ";
			objPstmt = objConn.prepareStatement(sql);			
			objPstmt.setString(1, bean.getaId());			
			objPstmt.setString(2, bean.getaPw());			
			objPstmt.setString(3, bean.getaName());			
			objPstmt.setString(4, bean.getaEmail());
			objPstmt.setString(5, bean.getaPhone());			
			int rowCnt = objPstmt.executeUpdate();
			
			if (rowCnt == 1) flag = true;
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		
		
		return flag;
	}

	public boolean Administratorlogin(String aId, String aPw) {
		boolean loginChkTF = false;
         
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "select * from adminList where aId = ? and aPw = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, aId);
			objPstmt.setString(2, aPw);
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				
				int recordCnt = objRS.getInt(1);
				if (recordCnt == 1) loginChkTF = true;   
				
			}
		   
	}catch(Exception e) {
		System.out.println("Exception e"+e.getMessage());
	}finally {
		objPool.freeConnection(objConn);
	}
		return loginChkTF;
    }
	
	/* 로그인 사용자 이름 반환(/bbs/write.jsp) 시작 */

	public String getaIdmtd(String aId) {
	
		String aName = "";
		String sql = null;
		
		try {			

			objPool = DBConnectionMgr.getInstance();			
			objConn = objPool.getConnection();
			sql = "select aId from adminList where aId=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, aId);
		
			objRS = objPstmt.executeQuery();
			if (objRS.next()) {
				aName = objRS.getNString(1);				
			}
		
		} catch (Exception e) {	
			System.out.println("Exception 이슈 : " + e.getMessage());	
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		
		return aName;
	}
	
	
	
}