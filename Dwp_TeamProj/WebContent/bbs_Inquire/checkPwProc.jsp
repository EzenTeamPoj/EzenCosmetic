<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush="true"%>
    
    <%@ page import="pack_Member.*"%>
<%@ page import="pack_BBS.*"%>
<%
request.setCharacterEncoding("UTF-8");
String numParam = request.getParameter("num");
int num = Integer.parseInt(numParam);
String nowPageParam = request.getParameter("nowPage");
int nowPage= Integer.parseInt(nowPageParam);
 
String bbsPwParam = request.getParameter("bbsPw");
int bbsPw= Integer.parseInt(bbsPwParam);

%>

<jsp:useBean id="chkMgr" class="pack_BBS.BoardMgr" />

<%
 int rtnCnt = chkMgr.getChkPw(num, bbsPw);

if (rtnCnt == 1) {
%>
<script>
window.opener.location.href="/bbs_Inquire/read.jsp?num=<%=num%>&nowPage=<%=nowPage%>";
 
window.close();
</script>
	
<%} else { %>
<script>
		alert("확인해주세요");
		location.href="/bbs_Inquire/checkPw.jsp?num=<%=num%>&nowPage=<%=nowPage%>";
         
</script>
<%} %>

