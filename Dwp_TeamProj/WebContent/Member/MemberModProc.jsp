<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<jsp:useBean id="mBean" class="pack_Member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<% request.setCharacterEncoding("UTF-8");%>

	
<%
int rowCnt =mMgr.updateMember(mBean);

if(rowCnt ==1){
   response.sendRedirect("/index.jsp");
}else{

}

%>
