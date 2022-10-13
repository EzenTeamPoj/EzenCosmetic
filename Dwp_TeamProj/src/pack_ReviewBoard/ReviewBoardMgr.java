package pack_ReviewBoard;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


import pack_DBCP.DBConnectionMgr;
import pack_Member.MemberBean;
import pack_ProdBoard.ProdBoardBean;

public class ReviewBoardMgr {
	
	private DBConnectionMgr objPool;
	
	Connection 				objConn;
	PreparedStatement 	objPstmt;
	Statement				 	objStmt;
	ResultSet 					objRS;
	
	private static final String SAVEFOLER = "C:/silsp/p07_JSP/Dwp_TeamProj_/WebContent/fileUpload";

	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;
	
	public ReviewBoardMgr() {
		try {
			objPool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	


/*  게시판 입력(/bbs/postProc.jsp) 시작  */
	public int insertBoard(HttpServletRequest req) {

		String sql = null;
		MultipartRequest multi = null;
		int fileSize = 0;
		String oriFileName = null;
		String sysFileName = null;
		
		int rtnCnt = 0;

		try {
			
			
			objConn = objPool.getConnection();

			File file = new File(SAVEFOLER);

			if (!file.exists())
				file.mkdirs();

			
			 multi = new MultipartRequest(
					 req,
					 SAVEFOLER,
					 maxSize,
					 encType,
					 new DefaultFileRenamePolicy()
					 );
			 int prodNum = Integer.parseInt( multi.getParameter("prodNum"));
			 sql = "select max(tblReviewNum) from reviewTbl where prodNum = ?";
			 objPstmt = objConn.prepareStatement(sql);
			 objPstmt.setInt(1, prodNum);
			 objRS = objPstmt.executeQuery();
			 
			 int tblReviewNum = 1; 
			 if (objRS.next())
				 tblReviewNum = objRS.getInt(1) + 1;
			 
			 
			 if (multi.getFilesystemName("upFileName") != null) {
				 	oriFileName = multi.getOriginalFileName("upFileName");
				 	sysFileName  = multi.getFilesystemName("upFileName");
					fileSize = (int) multi.getFile("upFileName").length();
				}
				 

			
			sql = "insert into reviewTbl (tblReviewNum, prodNum, regId, regName, subject, content, regDate, ip, love, oriFileName, sysFileName, fileSize ) ";
			sql += " values ( ?, ?, ?, ?, ?, ?, now(), ?, 0, ?, ?, ?)";
			  
			  objPstmt = objConn.prepareStatement(sql);
			  objPstmt.setInt(1, tblReviewNum);
			  objPstmt.setInt(2, prodNum);
			  objPstmt.setString(3, multi.getParameter("regId")); 
			  objPstmt.setString(4, multi.getParameter("regName")); 
			  objPstmt.setString(5, multi.getParameter("subject")); 
			  objPstmt.setString(6, multi.getParameter("content")); 
			  objPstmt.setString(7, multi.getParameter("ip")); 
			  objPstmt.setString(8, oriFileName); 
			  objPstmt.setString(9, sysFileName); 
			  objPstmt.setLong(10, fileSize); 
			  
			  rtnCnt = objPstmt.executeUpdate();
	  
	  
		/* System.out.println(rtnCnt); */
	 
		}catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}
				
		
		return rtnCnt;
		
	}
	/*  게시판 입력(/bbs/postProc.jsp) 끝  */
	
	
	/*  게시판 리스트 출력 (/bbs/list.jsp) 시작    */
	public Vector<ReviewBoardBean> getBoardList(String keyField, String keyWord, int start, int end, int prodNum) {

		Vector<ReviewBoardBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection(); //DbCp로 연동
			
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				sql = "select * from reviewTbl where prodNum = ? "
						+ " order by tblReviewNum desc limit ?, ?"; //start 와 end
				//DB에서는 ref  가 같으면 먼저 입력된글이 위로 올라온다. 
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, prodNum);
				objPstmt.setInt(2, start);
				objPstmt.setInt(3, end);
			} else {
				// 검색어가 있을 경우
				sql = "select * from reviewTbl "
						+ "where prodNum = ? and "+ keyField +" like ? "
						+ "order by tblReviewNum desc limit ?, ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, prodNum);
				objPstmt.setString(2, "%"+keyWord+"%");
				objPstmt.setInt(3, start);
				objPstmt.setInt(4, end);				
			}
			
			
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				ReviewBoardBean bean = new ReviewBoardBean();
				bean.setTotalReviewNum(objRS.getInt("totalReviewNum"));
				bean.setTblReviewNum(objRS.getInt("tblReviewNum"));
				bean.setRegId(objRS.getString("regId"));
				bean.setRegName(objRS.getString("regName"));
				bean.setSubject(objRS.getString("subject"));
				bean.setContent(objRS.getString("content"));
				bean.setRegDate(objRS.getString("regDate"));
				bean.setLove(objRS.getInt("love"));
				bean.setSysFileName(objRS.getString("sysFileName"));
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}


	/*  게시판 리스트 출력(/bbs/list.jsp) 끝  */

	
	/* 총 게시물 수(/product/prodList.jsp) 시작  */
	public int getTotalCount(String keyField, String keyWord, int prodNum)  {
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from reviewTbl where prodNum = ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, prodNum);
			} else {
				sql = "select count(*) from reviewTbl ";
				sql += "where prodNum = ? and "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, prodNum);
				objPstmt.setString(2, "%" + keyWord + "%");
			}

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
	
	
	/* 게시글 삭제(/bbs/delete.jsp) 시작 */
	public int deleteBoard(int totalReviewNum) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "select sysFileName from reviewTbl where totalReviewNum=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, totalReviewNum);
			objRS = objPstmt.executeQuery();

			if (objRS.next() && objRS.getString(1) != null) {
				if (!objRS.getString(1).equals("")) {
					String fName = objRS.getString(1);
					String fileSrc = SAVEFOLER + "/" + fName;
					File file = new File(fileSrc);

					if (file.exists())  file.delete(); // 파일 삭제 실행

				}
			}
			//////////// 게시글의 파일 삭제 끝 ///////////////

			//////////// 게시글 삭제 시작 ///////////////
			sql = "delete from reviewTbl where totalReviewNum=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, totalReviewNum);
			exeCnt = objPstmt.executeUpdate();
			//////////// 게시글 삭제 끝 ///////////////

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	/* 게시글 삭제(/bbs/delete.jsp) 끝 */
	
	
	
	/*게시글 수정페이지 시작*/
	public ReviewBoardBean modifyBoard(int totalReviewNum) {
		ReviewBoardBean objMB = null;
    
		try {
			objPool = DBConnectionMgr.getInstance();
			objConn = objPool.getConnection();		
			
			String sql = "select regId,regName,subject,content,sysFileName";
					 sql+= " from reviewTbl where totalReviewNum = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, totalReviewNum);
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				  objMB = new ReviewBoardBean();
				  objMB.setRegId(objRS.getString("regId")); 
	    		  objMB.setRegName(objRS.getString("regName"));
	    		  objMB.setSubject(objRS.getString("subject"));
	    		  objMB.setContent(objRS.getString("content"));
	    		  objMB.setSysFileName(objRS.getString("sysFileName"));

			}
		   
	}catch(Exception e) {
		System.out.println("Exception e"+e.getMessage());
	}finally {
		objPool.freeConnection(objConn);
	}
     return objMB;
		
    }
	
	public int updateBoard(ReviewBoardBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {
			
			objConn = objPool.getConnection();
			sql = "update reviewTbl set	subject=?, content=? where totalReviewNum=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getSubject());
			objPstmt.setString(2, bean.getContent());
			objPstmt.setInt(3, bean.getTotalReviewNum());
			exeCnt = objPstmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}

	
	/*게시글 수정페이지 끝*/
	
	/*게시글 추천 중복 방지 시작*/
	
	
	/*게시글 추천 중복 방지 끝*/
	public boolean recommendChkBoard(int totalReviewNum, String presserId) {
		String sql = null;
		boolean chkToF = true;

		try {
			objConn = objPool.getConnection();
			
			
			sql = "select * from reviewRecommed where totalReviewNum = ? and presserId = ? ";

			  
			  objPstmt = objConn.prepareStatement(sql);
			  objPstmt.setInt(1, totalReviewNum);
			  objPstmt.setString(2, presserId);
			  
			  objRS = objPstmt.executeQuery();
			  
			  if(objRS.next()) {
				  chkToF = false;
			  }
			
		} catch (Exception e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return chkToF;
	}
	/*게시글 추천 시작*/
	public int recommendBoard(int totalReviewNum, String presserId) {
		String sql = null;
		int rtnCnt = 0;
		boolean chkToF = true;
		

		try {
			objConn = objPool.getConnection();
			
			
			sql = "select * from reviewRecommed where totalReviewNum = ? and presserId = ? ";

			  
			  objPstmt = objConn.prepareStatement(sql);
			  objPstmt.setInt(1, totalReviewNum);
			  objPstmt.setString(2, presserId);
			  
			  objRS = objPstmt.executeQuery();
			  
			  if(objRS.next()) {
				  chkToF = false;
			  }
			
			  if (chkToF) {
				  sql = "insert into reviewRecommed (totalReviewNum, presserId, recommendTM ) ";
				  sql += " values ( ?, ?, now())";
				  
				  objPstmt = objConn.prepareStatement(sql);
				  objPstmt.setInt(1, totalReviewNum);
				  objPstmt.setString(2, presserId);
				  
				  rtnCnt = objPstmt.executeUpdate();
				  
				  sql = "update reviewTbl set love = love + 1 where totalReviewNum=?";
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setInt(1, totalReviewNum);
					objPstmt.executeUpdate();
					// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨
				  
			  } else {
				  rtnCnt = -1;
			  }
			
			
		} catch (Exception e) {
			System.out.println("SQL오류 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return rtnCnt;
	}
	/*게시글 추천 끝*/
	
	
}
