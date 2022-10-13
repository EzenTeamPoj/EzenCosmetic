<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="aMgr" class="pack_Admin.AdminMgr" />

<jsp:useBean id="aBean" class="pack_Admin.AdminBean" />
<jsp:setProperty name="aBean" property="*" />

<% boolean joinRes =aMgr.insertAdministrator(aBean);
%>

<script>
<% if (joinRes) { %>
	alert("회원가입하셨습니다.");
	location.href="/Admin/index.jsp";
<% } else { %>
	alert("회원가입 중 문제가 발생했습니다. 다시 시도해주세요.\n만일 문제가 계속될 경우 고객센터(02-1234-5678)로 연락해주세요.");
	history.back();
<% } %>
</script>