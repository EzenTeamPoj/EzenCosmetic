package pack_ProdBoard;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_ProdBoard.ProdBoardBean;
import pack_ProdBoard.UtilMgr;
import pack_DBCP.DBConnectionMgr;

public class ProdBoardMgr {
	private DBConnectionMgr objPool;
	
	Connection 				objConn;
	PreparedStatement 	objPstmt;
	Statement				 	objStmt;
	ResultSet 					objRS;
	
	private static final String SAVEFOLER = "C:/silsp/p07_JSP/Dwp_TeamProj_/WebContent/fileUpload";

	private static String encType = "UTF-8";
	private static int maxSize = 5 * 1024 * 1024;
	
	public ProdBoardMgr() {
		try {
			objPool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		}

	}
	
	
	/*  게시판 입력(/product/prodPostProc.jsp) 시작  */
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

			multi = new MultipartRequest(req, SAVEFOLER, maxSize, encType, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("imgFile") != null) {
				fileName = multi.getFilesystemName("imgFile");
				fileSize = (int) multi.getFile("imgFile").length();
			}
			String[] sellLabel = multi.getParameterValues("sellLabel");
			String[] sellLabelName = {"BEST", "NEW", "SALE", "NONE"};
			char[] sellLabelCode = {'0', '0', '0', '0'};
			for (int i=0; i<sellLabel.length; i++) {
				for(int j=0; j<sellLabelName.length; j++) {
					if (sellLabel[i].equals(sellLabelName[j])) {
						sellLabelCode[j] = '1';
					}
				}
			}

			int stockVolumn = Integer.parseInt(multi.getParameter("stockVolumn"));
			int salesVolumn = Integer.parseInt(multi.getParameter("salesVolumn"));
			int oriPrice = Integer.parseInt(multi.getParameter("oriPrice"));
			int sellPrice = Integer.parseInt(multi.getParameter("sellPrice"));

			
			sql = "insert into goodsTbl (";
			sql += "regId, pName, pType, stockVolumn, salesVolumn, oriPrice, sellPrice, sellLabel, content, ";
			sql += "regTM, readCnt, oriFileName, sysFileName, fileSize)";
			sql += " values (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), 0, ?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, multi.getParameter("regId"));
			objPstmt.setString(2, multi.getParameter("pName"));
			objPstmt.setString(3, multi.getParameter("pType"));
			objPstmt.setInt(4, stockVolumn);
			objPstmt.setInt(5, salesVolumn);
			objPstmt.setInt(6, oriPrice);
			objPstmt.setInt(7, sellPrice);
			objPstmt.setString(8, new String(sellLabelCode));
			objPstmt.setString(9, multi.getParameter("content"));
			objPstmt.setString(10, multi.getOriginalFileName("imgFile"));
			objPstmt.setString(11, fileName);
			objPstmt.setInt(12, fileSize);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

	}
	

	/*  게시판 입력(/product/prodPostProc.jsp) 끝  */
	
	
	/*  게시판 리스트 출력 (/product/prodList.jsp) 시작    */
	public Vector<ProdBoardBean> getBoardList(String keyWord, int start, int end, String orderBy, String typeSearch) {

		Vector<ProdBoardBean> vList = new Vector<>();
		String sql = null;
		orderBy = orderBy.replace("_", " ");
		
		try {
			objConn = objPool.getConnection();
			
			
			
			if (keyWord.equals("null") || keyWord.equals("")) {
				// 검색어가 없을 경우
				if(typeSearch.equals("전체")) {

					sql = "select * from goodsTbl "
							+ "order by "+orderBy+" limit ?, ?";
	
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setInt(1, start);
					objPstmt.setInt(2, end);					
				} else {
					sql = "select * from goodsTbl where pType = ? "
							+ "order by "+orderBy+" limit ?, ?";
					 
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, typeSearch);
					objPstmt.setInt(2, start);
					objPstmt.setInt(3, end);
				}
			} else {
				// 검색어가 있을 경우
				if(typeSearch.equals("전체")) {
					sql = "select * from goodsTbl where pName like ? "
							+ "order by "+orderBy+" limit ?, ?";
	
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, "%"+keyWord+"%");
					objPstmt.setInt(2, start);
					objPstmt.setInt(3, end);					
				} else {
					sql = "select * from goodsTbl where pName like ? and pType = ? "
							+ "order by "+orderBy+" limit ?, ?";
					 
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, "%"+keyWord+"%");
					objPstmt.setString(2, typeSearch);
					objPstmt.setInt(3, start);
					objPstmt.setInt(4, end);
				}
			}
			
			
			
			
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				ProdBoardBean bean = new ProdBoardBean();
				bean.setNum(objRS.getInt("num"));
				bean.setpName(objRS.getString("pName"));
				bean.setpType(objRS.getString("pType"));
				bean.setSysFileName(objRS.getString("sysFileName"));
				bean.setOriPrice(objRS.getInt("oriPrice"));
				bean.setSellPrice(objRS.getInt("sellPrice"));
				
				String[] sellLabelAry = new String[4];
				String sellLabel = objRS.getString("sellLabel");
				sellLabelAry=sellLabel.split("");
				bean.setSellLabel(sellLabelAry);
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println(sql);
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}



	/*  게시판 리스트 출력(/product/prodList.jsp) 끝  */

	
	/* 총 게시물 수(/product/prodList.jsp) 시작  */
	public int getTotalCount(String keyWord, String typeSearch)  {
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			if(keyWord.equals("null") || keyWord.equals("")) {
				if(typeSearch.equals("전체")) {
					sql = "select count(*) from goodsTbl";					
					objPstmt = objConn.prepareStatement(sql);
				} else {
					sql = "select count(*) from goodsTbl ";
					sql += "where pType = ?";
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, typeSearch);
				}
			} else {
				if(typeSearch.equals("전체")) {
					sql = "select count(*) from goodsTbl ";
					sql += "where pName like ?";					
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, "%" + keyWord + "%");
				} else {
					sql = "select count(*) from goodsTbl ";
					sql += "where pName like ? and pType = ?";
					objPstmt = objConn.prepareStatement(sql);
					objPstmt.setString(1, "%" + keyWord + "%");
					objPstmt.setString(2, typeSearch);
				}

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
	
	
	/* 게시판 뷰페이지 조회수 증가 시작 (/product/prodRead.jsp, 내용보기 페이지) */
	public void upCount(int num) {
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "update goodsTbl set readCnt = readCnt+1 where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objPstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

	} 
	/* 게시판 뷰페이지 조회수 증가 끝 (/product/prodRead.jsp, 내용보기 페이지) */
	
	
	/*	상세보기 페이지 게시글 출력 시작 (/product/prodRead.jsp, 내용보기 페이지) */
	public ProdBoardBean getBoard(int num) {
		String sql = null;

		ProdBoardBean bean = new ProdBoardBean();
		try {
			objConn = objPool.getConnection(); 
			sql = "select * from goodsTbl where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			objRS = objPstmt.executeQuery();

			if (objRS.next()) {
				bean.setNum(objRS.getInt("num"));
				bean.setpName(objRS.getString("pName"));
				bean.setpType(objRS.getString("pType"));
				bean.setStockVolumn(objRS.getInt("stockVolumn"));
				bean.setOriPrice(objRS.getInt("oriPrice"));
				bean.setSellPrice(objRS.getInt("sellPrice"));
				String[] sellLabelAry = new String[4];
				String sellLabel = objRS.getString("sellLabel");
				sellLabelAry=sellLabel.split("");
				bean.setSellLabel(sellLabelAry);
				bean.setContent(objRS.getString("content"));
				bean.setRegTM(objRS.getString("regTM"));
				bean.setReadCnt(objRS.getInt("readCnt"));
				bean.setSalesVolumn(objRS.getInt("salesVolumn"));
				bean.setSysFileName(objRS.getString("sysFileName"));
				bean.setFileSize(objRS.getInt("fileSize"));
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return bean;
	} 
	/*	상세보기 게시글 출력 끝 (/product/prodRead.jsp, 내용보기 페이지) */
	
	
	/* 게시글 삭제(/product/prodMod.jsp) 시작 */
	public int deleteBoard(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();

			////////////게시글의 파일 삭제 시작 ///////////////
			sql = "select sysFileName from goodsTbl where num=?";
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
			sql = "delete from goodsTbl where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();
			////////////게시글 삭제 끝 ///////////////

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	/* 게시글 삭제(/product/prodMod.jsp) 끝 */
	
	
	/* 게시글 수정페이지 (/product/prodModProc.jsp) 시작 */
	public int updateBoard(ProdBoardBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {
			
			String[] sellLabel = bean.getSellLabel();
			String[] sellLabelName = {"BEST", "NEW", "SALE", "NONE"};
			char[] sellLabelCode = {'0', '0', '0', '0'};
			for (int i=0; i<sellLabel.length; i++) {
				for(int j=0; j<sellLabelName.length; j++) {
					if (sellLabel[i].equals(sellLabelName[j])) {
						sellLabelCode[j] = '1';
					}
				}
			}
			
			objConn = objPool.getConnection();
			sql = "update goodsTbl set pName=?, pType=?, stockVolumn=?, salesVolumn = ?, oriPrice=?, sellPrice=?, sellLabel=?, content=? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getpName());
			objPstmt.setString(2, bean.getpType());
			/*수정된 부분*/
			objPstmt.setInt(3, bean.getStockVolumn());
			objPstmt.setInt(4, bean.getSalesVolumn());
			objPstmt.setInt(5, bean.getOriPrice());
			objPstmt.setInt(6, bean.getSellPrice());
			objPstmt.setString(7, new String(sellLabelCode));
			objPstmt.setString(8, bean.getContent());
			objPstmt.setInt(9, bean.getNum());
			exeCnt = objPstmt.executeUpdate();
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}

	/* 게시글 수정페이지 (/product/prodModProc.jsp) 끝 */
	
	/* 장바구니에 넣기 시작 */
	public int insertCart(CartBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {		
			objConn = objPool.getConnection();
			
			sql = "select num from cart where uId = ? and pNum = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuId());
			objPstmt.setInt(2, bean.getpNum());
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				int num = objRS.getInt("num");
				sql = "update cart set pVolumn = pVolumn + ? where num=?";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setInt(1, bean.getpVolumn());
				objPstmt.setInt(2, num);
				exeCnt = objPstmt.executeUpdate();
			} else {
				sql = "insert into cart (uId, pNum, pVolumn) values (?, ?, ?)";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, bean.getuId());
				objPstmt.setInt(2, bean.getpNum());
				objPstmt.setInt(3, bean.getpVolumn());
				exeCnt = objPstmt.executeUpdate();
			}
			
			
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}
	
	
	/* 장바구니에 넣기 끝 */
	
	
	/* 장바구니 리스트 시작*/
	public Vector<CartBean> getCartList(String uId) {

		Vector<CartBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "select cart.num, cart.uId, pNum, pVolumn, pName, sellPrice, sysFileName, stockVolumn ";
			sql	+= " from cart inner join goodsTbl on cart.pNum = goodsTbl.num ";
			sql += " where cart.uId = ? order by cart.num desc";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				CartBean bean = new CartBean();
				bean.setNum(objRS.getInt(1));
				bean.setuId(objRS.getString(2));
				bean.setpNum(objRS.getInt(3));
				bean.setpVolumn(objRS.getInt(4));
				bean.setpName(objRS.getString(5));
				bean.setSellPrice(objRS.getInt(6));
				bean.setSysFileName(objRS.getString(7));
				bean.setStockVolumn(objRS.getInt(8));
				
				vList.add(bean);
			}
		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}
	/* 장바구니 리스트 끝*/
	
	
	/////* 장바구니 리스트 삭제 시작*//////
	/* 장바구니 다중 삭제 시작 */
	public int deleteCartMulti(String [] numArr) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();
			
			for (int i = 0; i < numArr.length; i++) {
				sql = "delete from cart where num=?";
				objPstmt = objConn.prepareStatement(sql);
				int num = Integer.parseInt(numArr[i]);
				objPstmt.setInt(1, num);
				exeCnt += objPstmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	
	
	
	/* 장바구니 다중 삭제 끝 */
	
	
	/* 장바구니 개별 삭제 시작*/
	
	public int deleteCartOne(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();
			

			sql = "delete from cart where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	
	/* 장바구니 개별 삭제 끝*/
	
	//////* 장바구니 리스트 삭제 끝*//////
	
	
	/* 장바구니 수정 시작*/
	public int updateCart(int num, int pVolumn) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();
			
			sql = "update cart set pVolumn = ? where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, pVolumn);
			objPstmt.setInt(2, num);
			exeCnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}
	/* 장바구니 수정 끝*/
	
	
	
	
	
	/*///////// 위시리스트 출력 시작 //////////*/
	public Vector<WishlistBean> getWishlist(int start, int end, String uId) {

		Vector<WishlistBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "select wishlist.num, wishlist.uId, pNum, pName, sellPrice, sysFileName ";
			sql	+= " from wishlist inner join goodsTbl on wishlist.pNum = goodsTbl.num ";
			sql += " where wishlist.uId = ? order by wishlist.num desc limit ?, ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, uId);
			objPstmt.setInt(2, start);
			objPstmt.setInt(3, end);
			objRS = objPstmt.executeQuery();

			while (objRS.next()) {
				WishlistBean bean = new WishlistBean();
				bean.setNum(objRS.getInt(1));
				bean.setuId(objRS.getString(2));
				bean.setpNum(objRS.getInt(3));
				bean.setpName(objRS.getString(4));
				bean.setSellPrice(objRS.getInt(5));
				bean.setSysFileName(objRS.getString(6));
				
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
	public int getTotalWishlistCnt(String uId)  {
		String sql = null;
		int totalCnt = 0;

		try {
			objConn = objPool.getConnection();
			
			
			sql = "select count(*) from wishlist where uId = ?";
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
	
	
	/*///// 위시리스트 출력시작 끝 ///////*/
	
	/* 위시리스트에 넣기 시작 */
	public int insertWishlist(WishlistBean bean) {
		String sql = null;
		int exeCnt = 0;

		try {		
			objConn = objPool.getConnection();
			
			
			sql = "select num from wishlist where uId = ? and pNum = ?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, bean.getuId());
			objPstmt.setInt(2, bean.getpNum());
			objRS = objPstmt.executeQuery();
			
			if(objRS.next()) {
				exeCnt = -1;
			} else {
				sql = "insert into wishlist (uId, pNum) values (?, ?)";
				objPstmt = objConn.prepareStatement(sql);
				objPstmt.setString(1, bean.getuId());
				objPstmt.setInt(2, bean.getpNum());
				exeCnt = objPstmt.executeUpdate();
				
			}
			
			
			
			// exeCnt : DB에서 실제 적용된 데이터(=row, 로우)의 개수 저장됨

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt);
		}

		return exeCnt;
	}
	
	
	/* 위시리스트에 넣기 끝 */
	
	
	
	/////* 장바구니 리스트 삭제 시작*//////
	/* 장바구니 다중 삭제 시작 */
	public int deleteWishMulti(String [] numArr) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();
			
			for (int i = 0; i < numArr.length; i++) {
				sql = "delete from wishlist where num=?";
				objPstmt = objConn.prepareStatement(sql);
				int num = Integer.parseInt(numArr[i]);
				objPstmt.setInt(1, num);
				exeCnt += objPstmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	
	
	
	/* 장바구니 다중 삭제 끝 */
	
	
	/* 장바구니 개별 삭제 시작*/
	
	public int deleteWishOne(int num) {

		String sql = null;

		int exeCnt = 0; // 삭제 데이터 수, DB 삭제가 실행되었는지 여부 판단

		try {
			objConn = objPool.getConnection();
			

			sql = "delete from wishlist where num=?";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setInt(1, num);
			exeCnt = objPstmt.executeUpdate();


		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return exeCnt;
	}

	
	/* 장바구니 개별 삭제 끝*/
	
	//////* 장바구니 리스트 삭제 끝*//////
	
	
	
	/* 결제를 위해 장바구니 리스트 불러오기*/
	public Vector<CartBean> orderCartList(String orderId, String [] cartNum) {

		Vector<CartBean> vList = new Vector<>();
		String sql = null;

		try {
			objConn = objPool.getConnection();
			sql = "select pNum, pVolumn, sellPrice, pName from cart ";
			sql += " inner join goodsTbl on cart.pNum = goodsTbl.num ";
			sql += " where cart.uId = ? and cart.num = ?";
			objPstmt = objConn.prepareStatement(sql);
			for (int i = 0; i <cartNum.length; i++) {
				CartBean bean = new CartBean();
				objPstmt.setString(1, orderId);
				objPstmt.setInt(2, Integer.parseInt(cartNum[i]));
				objRS = objPstmt.executeQuery();
				if (objRS.next()) {
					bean.setpNum(objRS.getInt(1));
					bean.setpVolumn(objRS.getInt(2));
					bean.setSellPrice(objRS.getInt(3));
					bean.setpName(objRS.getString(4));
					
				}
				vList.add(bean);
			}

		} catch (Exception e) {
			System.out.println("Exception : " + e.getMessage());
		} finally {
			objPool.freeConnection(objConn, objPstmt, objRS);
		}

		return vList;
	}
	/* 장바구니 리스트 끝*/
	
	
	
	

}
