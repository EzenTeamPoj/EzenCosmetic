<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<jsp:useBean id="mBean" class="pack_Member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session");
boolean delRes =mMgr.deleteMember(uId_Session);
%>


<script>
<%
if (delRes) {
	session.invalidate();
%>	
	location.href="/index.jsp";
<%
} else {
%>	
	alert("비밀번호가 일치하지않습니다.");
	location.href="/Member/MemberDel.jsp";
<%
}
%>
</script>
