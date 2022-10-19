<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />

<jsp:useBean id="mBean" class="pack_Member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<% request.setCharacterEncoding("UTF-8");%>

<% boolean joinRes =mMgr.insertMember(mBean);%>
<script>
<% if (joinRes) { %>
	alert("회원가입하셨습니다.");
	location.href="/index.jsp";
<% } else { %>
	alert("회원가입 중 문제가 발생했습니다. 다시 시도해주세요.);
	history.back();
<% } %>
</script>