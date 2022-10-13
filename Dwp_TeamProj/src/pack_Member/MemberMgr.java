package pack_Member;

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

public class MemberMgr {
	
	Connection				objConn 		=		null;
	Statement					objStmt			=		null;	
	ResultSet					objRS			=		null;  	
	PreparedStatement 	objPstmt 		=		null; 
	DBConnectionMgr 		objPool 		= 		null;


	public static void main(String[] args) {
		new MemberMgr( );
	}
    // 회원가입
	public boolean insertMember(MemberBean bean) {
		
		boolean flag = false;
		
		
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
		    
			String sql = "insert into memberList (";
			sql += "uId, uPw, uName, uEmail, uPhone, uAge,";
			sql += " uAddr, uGender, uBirth, recoPerson, joinTM)";
			sql += " values (?, ?, ?, ?, ?, ?, ?, ? , ?, ?, now() )";
			objPstmt = objConn.prepareStatement(sql);			
			objPstmt.setString(1, bean.getuId());			
			objPstmt.setString(2, bean.getuPw());			
			objPstmt.setString(3, bean.getuName());			
			objPstmt.setString(4, bean.getuEmail());
			objPstmt.setString(5, bean.getuPhone());			
			objPstmt.setInt(6, bean.getuAge());			
			objPstmt.setString(7, bean.getuAddr());
			objPstmt.setInt(8, bean.getuGender());
			objPstmt.setString(9, bean.getuBirth());
			objPstmt.setString(10, bean.getRecoPerson());
			int rowCnt = objPstmt.executeUpdate();
			
			if (rowCnt == 1) flag = true;
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		
		
		return flag;
	}
	 // 회원가입 
	
	//회원 정보 목록 출력
	private Vector<MemberBean> objList = null;
	public List<MemberBean> mtd_Select() {


    	try{
    		objPool = DBConnectionMgr.getInstance();
    		objConn = objPool.getConnection();   
          
    	  String sql = "select * from memberList order by num desc";
    	  // " select num, uId, uPw, uName, uEmail, uPhone, ";
    	  // " uAge, uZipcode, uAddr, uGender, uBirth,recoPerson,joinTM";
    	  objStmt = objConn.createStatement();
    	  objRS =objStmt.executeQuery(sql);
    	  

         MemberBean objMB = null;
         objList = new Vector<MemberBean>();
    	  while(objRS.next()){
             		   
    		  objMB = new MemberBean();
    	     
    		  objMB.setNum(objRS.getInt("num"));
    		  objMB.setuId(objRS.getString("uId")); 
    		  objMB.setuPw(objRS.getString("uPw"));
    		  objMB.setuName(objRS.getString("uName"));
    		  objMB.setuEmail(objRS.getString("uEmail"));
    		  objMB.setuPhone(objRS.getString("uPhone"));
    		  objMB.setuAge(objRS.getInt("uAge")); 
    		  objMB.setuAddr(objRS.getString("uAddr")); 
    		  objMB.setuGender(objRS.getInt("uGender"));
    		  objMB.setuBirth(objRS.getString("uBirth"));
    		  objMB.setRecoPerson(objRS.getString("recoPerson"));
    		  objMB.setJoinTM(objRS.getString("joinTM"));
    		  objList.add(objMB);
    	  }
			
			 objRS.close();
			 objStmt.close();
			 objConn.close();
			 
    	} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
            return objList;
    }
	//회원 정보 목록 출력
	
	//회원 로그인
	public boolean Memberlogin(String uId, String uPw) {
		boolean loginChkTF = false;
         
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "select * from memberList where uId = ? and uPw = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objPstmt.setString(2, uPw);
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				
				loginChkTF = true;   
				
			}
		   
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		return loginChkTF;
    }
	//회원 로그인
	
	// 회원 정보 수정 시작
	public MemberBean modifyMember(String uId) {
		MemberBean objMB = null;
    
		try {
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "select uId,uPw,uName,uEmail,";
					 sql+= "uPhone,uAge,uAddr,uGender,uBirth";
					 sql+= " from memberList where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				  objMB = new MemberBean();
				  objMB.setuId(objRS.getString("uId")); 
	    		  objMB.setuPw(objRS.getString("uPw"));
	    		  objMB.setuName(objRS.getString("uName"));
	    		  objMB.setuEmail(objRS.getString("uEmail"));
	    		  objMB.setuPhone(objRS.getString("uPhone"));
	    		  objMB.setuAge(objRS.getInt("uAge")); 
	    		  objMB.setuAddr(objRS.getString("uAddr")); 
	    		  objMB.setuGender(objRS.getInt("uGender"));
	    		  objMB.setuBirth(objRS.getString("uBirth"));

			}
		   
	}catch(Exception e) {
		System.out.println("Exception e"+e.getMessage());
	}finally {
		objPool.freeConnection(objConn);
	}
     return objMB;
		
    }
	
	// 회원 정보 수정 끝
	
public int updateMember(MemberBean bean) {
		
        
	    int rowCnt = 0;
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
		    
			String sql = "update memberList set";
			sql += " uPw = ? ,uEmail =? , uPhone =? ,";
			sql += " uAddr = ? , uBirth = ?";
			sql += " where uId = ?";
			objPstmt = objConn.prepareStatement(sql);					
			objPstmt.setString(1, bean.getuPw());			
			objPstmt.setString(2, bean.getuEmail());			
			objPstmt.setString(3, bean.getuPhone());
			objPstmt.setString(4, bean.getuAddr());			
			objPstmt.setString(5, bean.getuBirth());
			objPstmt.setString(6, bean.getuId());
			
			rowCnt = objPstmt.executeUpdate();
			
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		return rowCnt;
				
	}


	//회원탈퇴
	public boolean deleteMember(String uId) {
		
		boolean flag = false;
		
		
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
		    
			String sql = "delete from memberList where uid= ?"; 
			objPstmt = objConn.prepareStatement(sql);			
			objPstmt.setString(1, uId);			
			
			int rowCnt = objPstmt.executeUpdate();
			
			if (rowCnt == 1) flag = true;
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		
		
		return flag;
	}
	// 회원탈퇴 
	
	public boolean checkId(String id) {
		
		boolean res = false;   // 임시 초기화, ID 사용 가능여부를 판별하는 변수
		                                    // true면 입력한 ID는 사용불가
		                                    // false면 입력한 ID는 사용가능		
		try {
						
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "select * from memberList where uId = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, id);
			objRS = objPstmt.executeQuery();
			
			if (objRS.next()) {
				
				res = true;   				
			}
						
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}
		
		return res;
	}
	
public int mtd_Del(MemberBean bean) {
		
		int rtnCnt = 0;
		
		try {
			
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
		    
			String sql = "delete from memberList where num=?";
			   objPstmt =objConn.prepareStatement(sql);
			   objPstmt.setInt(1,bean.getNum());   //문자자료형 C/N1
			  rtnCnt = objPstmt.executeUpdate();			
			
				
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
		
		
		return rtnCnt;
	}


    public int mtd_MultiDel(String[]num) {
     int rtnCnt = 0;
     
     try{
    	 objPool = DBConnectionMgr.getInstance();
    	 objConn = objPool.getConnection();
	 
	 for(int i = 0; i<num.length; i++) { 
	 String sql = "delete from memberList where num=?";
	 objPstmt =objConn.prepareStatement(sql);
	 objPstmt.setInt(1,Integer.parseInt(num[i])); //문자자료형 C/N1 rtnCnt =
	 rtnCnt = objPstmt.executeUpdate();	
	 }
	 }catch(Exception e){
	  System.out.print(e.getMessage());
	 
	  }finally {
		  objPool.freeConnection(objConn);
	  } 
     return rtnCnt; }
	
}