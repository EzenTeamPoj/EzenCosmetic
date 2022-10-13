<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush="true"%>

<%@page import="pack_BBS.BoardBean"%>
<%@page import="java.util.Vector"%>

<jsp:useBean id="lMgr" class="pack_BBS.BoardMgr" scope="page"/>



    <%
request.setCharacterEncoding("UTF-8");
    
String uId_Session = (String)session.getAttribute("uId_Session"); 
String aId_Session = (String)session.getAttribute("aId_Session"); 
///////////////////////페이징 관련 속성 값 시작///////////////////////////
// 페이징(Paging) = 페이지 나누기를 의미함
int totalRecord = 0;        // 전체 데이터 수(DB에 저장된 row 개수)
int numPerPage = 5;    // 한 페이지당 출력하는 데이터 수(=게시글 숫자)    
int pagePerBlock = 5;   // 블럭당 표시되는 페이지 수의 개수 <한 페이지에 나타나는 선택 가능한 최대 페이지 넘버>
int totalPage = 0;           // 전체 페이지 수
int totalBlock = 0;          // 전체 블록수
//class 속성에서 메서드 존재하는데 하위 구문, if 구문, 순환 제어문 등등에는 지역변수이기 때문에 초기화 하지 않고 사용하면 Error 뜸
// 차원이 달라요. {} 이 바깥에서 정의를 해줘야 사용할 수 있는데, {} 안에서 정의 된 것은 밖에서 사용할 수 없음.
// 그 있잖아, for안에 i는 바깥에서는 못 쓰는거잖아.
 /*  페이징 변수값의 이해 (계산해보자)
totalRecord=> 200     전체레코드
numPerPage => 10
pagePerBlock => 5
totalPage => 20
totalBlock => 4  (20/5 => 4)
*/
int nowPage = 1;          // 현재 (사용자가 보고 있는) 페이지 번호 무조건 1로 시작.
int nowBlock = 1;         // 현재 (사용자가 보고 있는) 블럭
int start = 0;     // DB에서 데이터를 불러올 때 시작하는 인덱스 번호
int end = 5;     // 시작하는 인덱스 번호부터 반환하는(=출력하는) 데이터 개수 
                          // select * from T/N where... order by ... limit start, end;
						//데이터가 6개면 2페이지가 나오겠지 그리고 한 페이지에 출력은 5개 까지
						//                                                                인덱스번호 5 이므로 6번 자료를 의미 5개
int listSize = 0;    // 1페이지에서 보여주는 데이터 수
						//출력할 데이터의 개수 = 데이터 1개는 가로줄 1개
						
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
/*
 select * from tblBoard order by num desc limit 10, 10;   전체 num를 desc로 반환하는데 10번째 부터 10개 반환 (90번부터 89번까지 반환함)
데이터가 100개   =>   num :  100  99   98    97 ... 91 |  90      ... 2  1    1
                       start, end :   0    1    2     3....   9      10
페이지당 출력할 데이터 수 10개
현재 페이지 1페이지라면    => 1페이지의 출력결과   100 ~ 91
2(=nowPage가 2라는 의미) 페이지   90~81
3페이지    80~71
*/
totalRecord = lMgr.getTotalCountInq(keyField, keyWord);   
totalPage = (int)Math.ceil((double)totalRecord/numPerPage);       //전체글 나누기 / 페이지당 출력 글수 = totalPage Math.ceil 올림 round반올림 flour내림
nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);			//0.2 올림 1됨
totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);		//0.2 올림 1됨...
///////////////////////페이징 관련 속성 값 끝///////////////////////////
    Vector<BoardBean> vList  = null;
    //List는 인터페이스 > Vector는 클래스 벡터 클래스가 가지고 있는 메서드 속성을 다 쓸수 있음.
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>리스트페이지</title>
<link rel="shortcut icon" href="#">
<link rel="stylesheet" href="/style/common_style.css">
<link rel="stylesheet" href="/style/style_BBS_Inq.css">
<script src="/script/jquery-3.6.0.min.js"></script>
<script src="/script/script_Inquire.js"></script>
</head>
<body>

    <div id="wrap">

		<main id="main" class="dFlex">
	

	    	<!-- 실제 작업 영역 시작 -->
    		<div id="contents" class="bbsList">

    		<%
				String prnType ="";
    		
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

			<table id="boardList">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>		
					<tr>
						<td colspan="5" class="spaceTd"></td>
					</tr>		
			<%
			vList = lMgr.getInquireList(keyField, keyWord,start, end);  // DB에서 데이터 불러오기
			listSize = vList.size();			
			
				if (vList.isEmpty()) {
					// 데이터가 없을 경우 출력 시작
				%> 
					<tr>
						<td colspan="5">
						<%="게시물이 없습니다." %>
						</td>
					</tr>				
				<%
					// 데이터가 없을 경우 출력 끝
				} else {
					// 데이터가 있을 경우 출력 시작
				%>
				</thead>
				<tbody>





				<%
				BoardBean bean = null;
				
					for (int i=0; i<numPerPage; i++) {		
						
						if(i==listSize) break; // 페이지 마다 출력되는 글 수(변동) i가 listSize(글 수) 랑 같으면 멈춰야지
						
						bean = vList.get(i);
						
						int num = bean.getNum(); // 글자 고유 순서값
						String uName = bean.getuName();
						String subject = bean.getSubject();
						String regTM = bean.getRegTM();
						int depth = bean.getDepth();
						int readCnt = bean.getReadCnt();
				%>
					<tr class="listTr" onclick="read('<%=bean.getNum()%>', '<%=nowPage%>','<%=aId_Session%>')">
				<script>
				function read(p1, p2, p3) {
					let num = p1;
					let nowPage = p2;
					let aId=p3;
					 
					let url ="/bbs_Inquire/read.jsp?";
					url+="num="+num;
					url+="&nowPage="+nowPage;
					
					
					
					let param = "/bbs_Inquire/checkPw.jsp?num="+num;
					param += "&nowPage=" +nowPage;
					
					if(aId=="admin"){
					location.href=url;
					} else {
					
					window.open(param,"","width=500px,height=500px");
					}
				}
				</script>





						<td>
							<% if (depth == 0) out.print(num);   // 답변글이 아님을 의미함 %>
							<%  if (depth > 0)  out.print(num);  %>
							
						</td> 
						<td class="subjectTd">
							<% 
								 if (depth > 0) {    // 답변글 의미. 들여쓰기.
										 
									 for(int blank=0; blank<depth; blank++) {
										 out.print("&nbsp;&nbsp;");
									 }
									out.print("<img src='/img/replyImg.png' alt='reply'>&nbsp;");
								 } 
								out.print(subject); 
							%>
						</td>
						<td><%=uName %></td>
						<td><%=regTM %></td>
						<td><%=readCnt %></td>

					</tr>

				<%
					}	// end for  데이터가 있을 경우 출력 끝
				}   // end if  	
				%>

					<tr id="listBtnArea">
						<td colspan="1">

							<%if(uId_Session==null){	 
						 %>
							<button type="button" id="loginAlertBtn" class="listBtnStyle">글쓰기</button>

					<%} 	else { %>
							<button type="button" id="inqBtn" class="listBtnStyle">글쓰기</button>
					<%} %>			

						</td>

						<td colspan="4">

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
					 size="20" maxlength="30" value="<%=keyWord%>">
								</div>
								<div>
									<button type="button" id="searchBtn" class="listBtnStyle">검색</button>
								</div>

							</form>

						<input type="hidden" id="pKeyField" value="<%=keyField%>">
							<input type="hidden" id="pKeyWord" value="<%=keyWord%>">



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
					
					
								<span class="moveBlockArea" onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>','pb')"> &lt;</span>
								   <!-- 이 전 페이지 마지막으로 이동하는 것으로 수정하기  -->
								   <script>
								   function moveBlock(p1, p2, param3) {    // 블럭 이동 ,전 블럭의  ''마지막'' 페이지로 이동함 p1: nowBlock-1 
										let pageNum = parseInt(p1);  // 이전 블럭의 시작페이지로 이동할 때 사용
										let pagePerBlock = parseInt(p2);	 //5
										
										//alert("p1(moveBlock) : " + p1 + "\np2(pagePerBlock) : " + p2 );
										
									    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
									    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
										
										
										if(param3=='pb'){
											 param = "/bbs_Inquire/list.jsp?nowPage="+(moveBlock*pagePerBlock);
										     param += "&keyField="+p3;
										     param += "&keyWord="+p4 ; 
										}else if(param3=='nb'){
											param = "/bbs_Inquire/list.jsp?nowPage="+(pagePerBlock*(moveBlock-1)+1);
										     param += "&keyField="+p3;
										     param += "&keyWord="+p4 ; 
											
										}
										location.href=param;
									}
								   </script>
					<% } else { %>
					            <span class="moveBlockArea" ></span>
					<% } %>
				
					<!-- 페이지 나누기용 페이지 번호 출력 시작  -->
					<% 
					
					
					
					
					             // 2        <     6       
					             // for (초기식; 조건식 ; 증감식 ){}
					             // for (          ; 조건식; 증감식;){} 초기식은 조건식의 변수가
					             //for 구문 사용 이전에 명시되어 있으므로 그 변수를 활용한다.
					             //너무 길어서 못넣어 ㅠㅠ
						for (int i=pageStart   ; i<=pageEnd; i++) { %>
							<% if (i == nowPage) {   // 현재 사용자가 보고 있는 페이지 %>
								<span class="nowPageNum"><%=i %></span>
							<% } else {                              // 현재 사용자가 보고 있지 않은 페이지 %>
							 	<span class="pageNum" onclick="movePage('<%=i %>')">
							 	<script>
							 	function movePage(p1) {    // 페이지 이동
							 		
							 		
							 		
							 	    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
							 	    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
							 		let param = "/bbs_Inquire/list.jsp?nowPage="+p1;	    
							 		     param += "&keyField="+p3;
							 		     param += "&keyWord="+p4 ; 
							 		location.href= param;
							 	}
							 	</script>
							 	
							 	
									<%=i %>
							 	</span>					
							<% } // End If%>		 	
					<% }  // End For%>
					<!-- 페이지 나누기용 페이지 번호 출력 끝  -->	
					
				
				
							<% if (totalBlock>nowBlock) { // 다음 블럭이 남아 있다면  %>
							<span  class="moveBlockArea" onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>', 'nb')">
							&gt;
							</span>
							
							<script>
							function moveBlock(p1, p2, param3) {    // 블럭 이동 ,전 블럭의  ''마지막'' 페이지로 이동함 p1: nowBlock-1 
								let pageNum = parseInt(p1);  // 이전 블럭의 시작페이지로 이동할 때 사용
								let pagePerBlock = parseInt(p2);	 //5
								
								alert("p1(moveBlock) : " + p1 + "\np2(pagePerBlock) : " + p2 );
								
							    let p3 = $("#pKeyField").val().trim();  // p3 : keyField
							    let p4 = $("#pKeyWord").val().trim();  // p4 : keyWord
								
								
								if(param3=='pb'){
									 param = "/bbs_Inquire/list.jsp?nowPage="+(moveBlock*pagePerBlock);
								     param += "&keyField="+p3;
								     param += "&keyWord="+p4 ; 
								}else if(param3=='nb'){
									param = "/bbs_Inquire/list.jsp?nowPage="+(pagePerBlock*(moveBlock-1)+1);
								     param += "&keyField="+p3;
								     param += "&keyWord="+p4 ; 
									
								}
								location.href=param;
							}
							</script>
			
				<% } else { %>
				            <span class="moveBlockArea"></span>
				<% } %>
				
					
				<%
				} else {
					out.print("<b>[ Paging Area ]</b>"); // End if 1이라고 표현하기도 함
				}
				%>						
						
						</td>
					</tr>
					
				</tbody>
			</table>
		
		
    		</div>
    		<!-- 실제 작업 영역 끝 -->
    		    	
    	</main>
    	<!--  main#main  -->
		
		
    </div>
    <!-- div#wrap  -->
</body>
</html>