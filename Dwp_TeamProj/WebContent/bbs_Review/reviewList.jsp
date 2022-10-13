<%@page import="pack_ReviewBoard.ReviewBoardBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/err/errorProc.jsp"%>
<jsp:useBean id="objBoard" class="pack_ReviewBoard.ReviewBoardMgr" />
<jsp:useBean id="objOrder" class="pack_Order.OrderMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	
	String uId_Session = (String)session.getAttribute("uId_Session"); 
	String aId_Session = (String)session.getAttribute("aId_Session"); 

	int prodNum = Integer.parseInt(request.getParameter("prodNum"));
	//동진씨 list작업물 복붙
	
	int orderCnt = objOrder.getTotalOrderList(uId_Session, prodNum);

	///////////////////////페이징 관련 속성 값 시작///////////////////////////
	// 페이징(Paging) = 페이지 나누기를 의미함
	int totalRecord = 0;        // 전체 데이터 수(DB에 저장된 row 개수)
	int numPerPage = 5;    // 한 페이지당 출력하는 데이터 수(=게시글 숫자)    
	int pagePerBlock = 5;   // 블럭당 표시되는 페이지 수의 개수 <한 페이지에 나타나는 선택 가능한 최대 페이지 넘버>
	int totalPage = 0;           // 전체 페이지 수
	int totalBlock = 0;          // 전체 블록수


	int nowPage = 1;          // 현재 (사용자가 보고 있는) 페이지 번호 무조건 1로 시작.
	int nowBlock = 1;         // 현재 (사용자가 보고 있는) 블럭
	
	int start = 0;     // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
	int end = 5;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
	                          // select * from T/N where... order by ... limit start, end;
							//데이터가 6개면 2페이지가 나오겠지 그리고 한 페이지에 출력은 5개 까지
							//                                                                인덱스번호 5 이므로 6번 자료를 의미 5개
	
	int listSize = 0;    // 1페이지에서 보여주는 데이터 수
							//출력할 데이터의 개수 = 데이터 1개는 가로줄 1개
	
	// 게시판 검색 관련소스
	String keyField = ""; // DB의 컬럼명
	String keyWord = ""; // DB의 검색어
							
	if (request.getParameter("keyWord") != null) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	
							
	if (request.getParameter("nowPage") != null) { // nowpage 값을 전달하고 받는 것. 비어 있지 않다면
		nowPage = Integer.parseInt(request.getParameter("nowPage"));     //nowPage 를 숫자로 바꿔서
		start = (nowPage * numPerPage) - numPerPage;   // start 에 nowpage * numPerPage  2 페이지라면 start 5 
		end = numPerPage;            // 2 페이지여도 5
		//end가 가져올 row의 갯수를 뜻함.
	}


	totalRecord = objBoard.getTotalCount(keyField, keyWord, prodNum);   
	// 전체 데이터 수 반환
	
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);       //전체글 나누기 / 페이지당 출력 글수 = totalPage Math.ceil 올림 round반올림 flour내림
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);			//0.2 올림 1됨
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);		//0.2 올림 1됨...

///////////////////////페이징 관련 속성 값 끝///////////////////////////



    Vector<ReviewBoardBean> vList  = null;
    //List는 인터페이스 > Vector는 클래스 벡터 클래스가 가지고 있는 메서드 속성을 다 쓸수 있음.
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>리뷰페이지</title>
		<link rel="stylesheet" href="/style/common_style.css">
		<link rel="stylesheet" href="/style/review_style.css">
		<link rel="shortcut icon" href="#">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/script/script_Review.js"></script>
	</head>
	<body>
		<div id="wrap" class="reviewListWrap">
			<main id="main">
		    	<!-- 실제 작업 영역 시작 -->
	    		<div id="contents" class="bbsList">

		    		<h1>후기</h1>	    			

	    		<%
					String prnType = "";
					if (keyWord.equals("null") || keyWord.equals("")) {
						prnType = "전체 게시글";
					} else {
						prnType = "검색 결과";
					}
				%>
	    		
		    		<div id="pageInfo" class="dFlex">
						<span><%=prnType %> :  <%=totalRecord%> 개</span>
						<span>페이지 :  <%=nowPage + " / " + totalPage%></span>  
					</div>	
				<%
				vList = objBoard.getBoardList(keyField, keyWord, start, end, prodNum);  // DB에서 데이터 불러오기
				listSize = vList.size();			
				
					if (vList.isEmpty()) {
						// 데이터가 없을 경우 출력 시작
				%> <table class="reviewNoTbl">
						<tbody>
							<tr>
								<td>
								<%="등록된 상품평이 없습니다." %>
								</td>
							</tr>
						</tbody>
					</table>				
					<%
						// 데이터가 없을 경우 출력 끝
					} else {
						// 데이터가 있을 경우 출력 시작
					%>
						
								
					<%
						for (int i=0; i<numPerPage; i++) {		
							
							if(i==listSize) break; // 페이지 마다 출력되는 글 수(변동) i가 listSize(글 수) 랑 같으면 멈춰야지
							
							ReviewBoardBean bean = vList.get(i);
							int totalReviewNum = bean.getTotalReviewNum();
							int tblReviewNum = bean.getTblReviewNum();
							String regId = bean.getRegId();
							String regName = bean.getRegName();
							String subject = bean.getSubject();
							String content = bean.getContent();
							String regTM = bean.getRegDate();
							int love = bean.getLove();
							String sysFileName = bean.getSysFileName();
							
							String [] regTMArr = regTM.split(" ");
	
					%>
					
	
					<!--  게시글 상세보기 페이지 내용 출력 시작 -->
					<h2><%=subject %></h2>
					
					<table class="reviewListTbl">
						<tbody id="readTblBody">
							<tr>
								<td>작성자</td>
							</tr>
							<tr>  
								<td><%=regName %></td>
							</tr>
							<tr>
								<td colspan="2"><%=regTMArr[0] %></td>
							</tr>
							<tr>
								<td colspan="2">
								<% if(sysFileName != "" && sysFileName != null) { %>
									<img src="/fileUpload/<%=sysFileName %>" alt="리뷰이미지" width="100" height="100">
								<% } %>
								</td>
							</tr>
							<tr>
								<td colspan="2" id="readContentTd"><pre><%=content %></pre></td>
							</tr>				
							<tr>
								<td colspan="2" id="btnAreaTd" class="read">
									<% if (uId_Session != null && !regId.equals(uId_Session)) { %>
									<button type="button" class="recommendBtn">도움이 돼요</button>
									<span><%=love %>명이 추천하셨습니다.</span>
									<br>
									<% } %>
									<input type="hidden" class="totalReviewNum" name="totalReviewNum" value="<%=totalReviewNum %>">
									<% 
										// out.print("uId_Session : "+ uId_Session + "<br>" + "uId : "+ uId);
										if (regId.equals(uId_Session)||aId_Session != null)  { 
									%> 
									<button type="button" class="modBtn">수 정</button>
									<button type="button" class="delBtn">삭 제</button>
									 <% } %> 
								</td>				
							</tr>
						</tbody>
					</table>
					<hr>
					<% 		} //for End %>
					<% }   //if End%>
					<table>
						<tbody>
							<tr id="listBtnArea">
								<td colspan="2">
								<input type="hidden" id="orderCnt" value="<%=orderCnt%>">
								 <% if (uId_Session == null && aId_Session == null) { %>
									<button type="button" id="loginAlertBtn" class="listBtnStyle">글쓰기</button>
								<% } else { %> 
									<button type="button" id="writeBtn" class="listBtnStyle">글쓰기</button>
							 	<% } %> 
								</td>
								
								<td colspan="3">
								
									<form name="searchFrm" class="dFlex"
											id="searchFrm">
									
										<div>
											<select name="keyField" id="keyField">
												<option value="subject" 
														<% if(keyField.equals("subject")) out.print("selected"); %>>제  목</option>
												<option value="uName" 
														<% if(keyField.equals("uName")) out.print("selected"); %>>이  름</option>
												<option value="content" 
														<% if(keyField.equals("content")) out.print("selected"); %>>내  용</option>
											</select>
										</div>
										<div>
											<input type="text" name="keyWord" id="keyWord"
											  id="keyWord" size="20" maxlength="30" value="<%=keyWord%>">
										</div>
										<div>
											<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
										</div>
																	
									</form>
									
									<!-- 상품번호 유지용 매개변수 데이터시작 -->
									<input type="hidden" id="prodNum" value="<%=prodNum %>">
									<!-- 상품번호 유지용 매개변수 데이터끝 -->
									<!-- 검색결과 유지용 매개변수 데이터시작 -->
									<input type="hidden" id="nowPage" value="<%=nowPage %>">
									<input type="hidden" id="pKeyField" value="<%=keyField%>">
									<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
									<!-- 검색결과 유지용 매개변수 데이터끝 -->
								
								</td>
							</tr>  <!-- tr#listBtnArea -->
							
							<tr id="listPagingArea">
								
							<!-- 페이징 시작 -->
								<td colspan="5" id="pagingTd">
						<%
						int pageStart = (nowBlock - 1 ) * pagePerBlock + 1;
						//블럭 첫번째 페이지
									// 26개 자료기준
									// 현재 기준 numPerPage : 5;    // 페이지당 출력 데이터 수
									//            pagePerBlock : 5;  //  블럭당 페이지 수
									//            nowBlock : 현재블럭
									//            totalBlock : 전체블럭
									//  -------------------------------------------------
									//            totalRecord : 26    totalPage : 6 Math.ceil로 올려서 6됨
									// 적용결과  nowBlock : 1  =>   pageStart : 1   pageEnd : 5
									//            nowBlock : 2  =>   pageStart : 6   pageEnd : 6( = totalPage)
									//
						int pageEnd = (nowBlock < totalBlock) ? 
								//블럭 마지막 페이지 
														pageStart + pagePerBlock - 1 :  totalPage;
									
									//마지막 블럭이 아니면 pageEnd 값은 pageStart + pagePerBlock - 1 이고 마지막 블럭이라면 totalPage 실행
									//여기서 pageEnd 값은 해당 블럭의 마지막 페이지를 의미.
									// 즉 1블럭에서는 pageStart 1(페이지) pagePerBlock 10 이므로 pageEnd 는 계산하면 10
									// 2블럭에서는 (2-1) *(10) +1 = 11 pagePerBlock 10 이므로  pageEnd 는 계산하면 20
									//마지막 블럭에서는 pageStart 41 pagePerBlock 10
									//						nowBlock 5 totalBlock도 5 라서 식에서 false 나오니까 totalPage가 실행됨. pageEnd는 41이 됨.
									
									//삼항 연산자   (nowBlock < totalBlock) true면 pageStart + pagePerBlock - 1 이게 실행되고 
									//(nowBlock < totalBlock)  false 라면 totalPage 실행됨.
									
									//3항 연산자 (=조건 연산자) => 조건식 ? true 일때 결과(A) : false 일때 결과 (B); 
						                                        
						// 블럭당 5페이지 출력 =>        pageStart    pageEnd
						//                          1블럭        1                 5
						//                          2블럭        6                 10    		
						// 블럭마다 시작되는 첫 페이지와 마지막 페이지 관련 작업				
						if (totalPage != 0) {   //   전체 페이지가 0이 아니라면 = 게시글이 1개라도 있다면
							// #if01_totalPage   
						%>
							
							<% if (nowBlock>1) { 	   // 페이지 블럭이 2이상이면 => 2개이상의 블럭이 있어야 가능 %>
										<span class="moveBlockArea" onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>','pb')">
										&lt;    <!-- 이 전 페이지 마지막으로 이동하는 것으로 수정하기  -->
										</span>
							<% } else { %>
							            <span class="moveBlockArea" ></span>
							<% } %>
						
							<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
							<% 
							
		
								for (int i=pageStart   ; i<=pageEnd; i++) { %>
									<% if (i == nowPage) {   // 현재 사용자가 보고 있는 페이지 %>
										<span class="nowPageNum"><%=i %></span>
									<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
									 	<span class="pageNum" onclick="movePage('<%=i %>')">
											<%=i %>
									 	</span>					
									<% } // End If%>		 	
							<% }  // End For%>
							<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
							
						
						<% if (totalBlock>nowBlock) { // 다음 블럭이 남아 있다면  %>
									<span  class="moveBlockArea" onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>', 'nb')">
									&gt;
									</span>
					
						<% } else { %>
						            <span class="moveBlockArea"></span>
						<% } %>
						
							
						<%
						} else {
							out.print("<b>[1]</b>"); // End if 1이라고 표현하기도 함
						}
						%>						
								
								</td>
							</tr>
						
					</tbody>
				</table>
			
			
	    		</div>
	    		<!-- 실제 작업 영역 끝 -->
			
			</main>
    		    	

		
		
		</div>
		<!-- div#wrap -->
	</body>
</html>