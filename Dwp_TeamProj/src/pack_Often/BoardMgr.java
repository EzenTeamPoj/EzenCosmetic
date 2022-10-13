package pack_Often;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_DBCP.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr objPool;
	
	Connection 				objConn 		= 		null;
	PreparedStatement 	objPstmt 		= 		null;
	Statement				 	objStmt 		= 		null;
	ResultSet 					objRS 			= 		null;
	
	private static final String SAVEFOLER = "C:/silsp/p07_JSP/Dwp_TeamProj_/WebContent/fileUploadSec";
	// 작업자의 워크스페이스가 다르다면 파일이 업로드되는 경로도 그에 맞게 설정해야 함.
	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;

	public BoardMgr() {
		try {
			objPool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	

/*  게시판 입력(/bbs_Often/writeProc.jsp) 시작  */
	public void insertBoard(HttpServletRequest req) {

		String sql = null;
		MultipartRequest multi = null;
		int fileSize = 0;
		String fileName = null;
		
		try {
			objConn = objPool.getConnection();
			
			File file = new File(SAVEFOLER);
			
			if (!file.exists())
				file.mkdirs();
			
			multi = new MultipartRequest(req,
					SAVEFOLER,
					maxSize,
					encType,
					new DefaultFileRenamePolicy());
			
			if (multi.getFilesystemName("fileName") != null) {
				fileName = multi.getFilesystemName("fileName");
				fileSize = (int) multi.getFile("fileName").length();
			}
			
			String content = multi.getParameter("content");

			sql = "insert into OftenTbl (aId,aName,subject, qnaType ,content, ";
			sql += "regTM,readCnt, fileName, fileSize) values (?,?,?, ?, ?, now(),0, ?, ?)";

			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, multi.getParameter("aId"));
			objPstmt.setString(2, multi.getParameter("aName"));
			objPstmt.setString(3, multi.getParameter("subject"));
			objPstmt.setString(4, multi.getParameter("qnaType"));
			objPstmt.setString(5, content);
			objPstmt.setString(6, fileName);
			objPstmt.setInt(7, fileSize);
			objPstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

	}
	/*  게시판 입력(/bbs_Often/writeProc.jsp) 끝  */
	
	


	/*  게시판 리스트 출력 (/bbs_Often/list.jsp) 시작    */
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {

		Vector<BoardBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				sql = "select * from OftenTbl "
						+ "order by num desc limit ?,?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, start);
				objPstmt.setInt(2, end);
			} else {
				// 검색어가 있을 경우
				sql = "select * from OftenTbl where "+ keyField +" like ? "
						+ " order by num desc limit ?,?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%"+keyWord+"%");
				objPstmt.setInt(2, start);
				objPstmt.setInt(3, end);				
			}
			
			
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(objRS.getInt("num"));
				bean.setaId(objRS.getString("aId"));
				bean.setSubject(objRS.getString("subject"));
				bean.setContent(objRS.getString("qnaType"));
				bean.setRegTM(objRS.getString("regTM"));
				bean.setReadCnt(objRS.getInt("readCnt"));
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

	

	/* 총 게시물 수(/bbs/list.jsp) 시작  */
	public int getTotalCount(String keyField, String keyWord) {

		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from OftenTbl";
				objPstmt = objConn.prepareStatement(sql);
			} else {
				sql = "select count(*) from OftenTbl ";
				sql += "where "+keyField+" like ?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, "%" + keyWord + "%");
			}

			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				totalCnt = objRS.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("SQL이슈 : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return totalCnt;
	}
	/* 총 게시물 수(/bbs/list.jsp) 끝  */
	

	
	
	
	/* 게시판 뷰페이지 조회수 증가 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public void upCount(int num) {
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "update OftenTbl set readCnt = readCnt+1 where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

	} 
	/* 게시판 뷰페이지 조회수 증가 끝 (/bbs/read.jsp, 내용보기 페이지) */
	
	

	/*	상세보기 페이지 게시글 출력 시작 (/bbs/read.jsp, 내용보기 페이지) */
	public BoardBean getBoard(int num) {
		String sql = null;

		BoardBean bean = new BoardBean();
		try {
			objConn = objPool.getConnection(); 
			sql = "select * from OftenTbl where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				bean.setNum(objRS.getInt("num"));
				bean.setaId(objRS.getString("aId"));
				bean.setSubject(objRS.getString("subject"));
				bean.setQnaType(objRS.getString("qnaType"));
				bean.setContent(objRS.getString("content"));
				bean.setRegTM(objRS.getString("regTM"));
				bean.setReadCnt(objRS.getInt("readCnt"));
				bean.setFileName(objRS.getString("fileName"));
				bean.setFileSize(objRS.getInt("fileSize"));
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return bean;
	} 
	/*	상세보기 게시글 출력 끝 (/bbs/read.jsp, 내용보기 페이지) */

	
	/*
	public static void main(String[] args) {
		System.out.println(len);
	}
	*/

	
	/* 상세보기 페이지 파일다운로드 시작 (/bbs/read.jsp) */
	public static int len;
	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {
		String fileName = req.getParameter("fileName"); // 다운로드할 파일 매개변수명 일치
		try {
			File file = new File(UtilMgr.con(SAVEFOLER + File.separator + fileName));

			byte[] b = new byte[(int) file.length()];
			res.setHeader("Accept-Ranges", "bytes");
			String strClient = req.getHeader("User-Agent");
			res.setContentType("application/smnet;charset=utf-8");
			res.setHeader("Content-Disposition", "attachment;fileName=" + fileName + ";");

			out.clear();
			out = pageContext.pushBody();

			if (file.isFile()) {
				BufferedInputStream fIn = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream fOuts = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while ((read = fIn.read(b)) != -1) {
					fOuts.write(b, 0, read);
				}
				fOuts.close();
				fIn.close();

			}

		} catch (Exception e) {
			System.out.println("파일 처리 이슈 : " + e.getMessage());
		}

	}

	/* 상세보기 페이지 파일다운로드 끝 (/bbs/read.jsp) */
	
	

	/* 게시글 삭제(/bbs/delete.jsp) 시작 */
	public int deleteBoard(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();

			//////////// 게시글의 파일 삭제 시작 ///////////////
			sql = "select fileName from OftenTbl where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
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
			sql = "delete from OftenTbl where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
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

	

	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 시작 */
	public int updateBoard(BoardBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {
			objConn = objPool.getConnection();
			sql = "update OftenTbl set aId=?, subject=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getaId());
			objPstmt.setString(2, bean.getSubject());
			objPstmt.setString(3, bean.getContent());
			objPstmt.setInt(4, bean.getNum());
			exeCnt = objPstmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}

	/* 게시글 수정페이지 (/bbs/updateProc.jsp) 끝 */

}
