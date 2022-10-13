<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" autoFlush = "true"%>
<%@page import="java.util.List"%>
<%@page import="pack_Member.MemberBean"%>
<%@page import="java.sql.*"%>
<jsp:useBean id="mMgr" class="pack_Member.MemberMgr" />
<jsp:useBean id="mBean" class="pack_Member.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<%
request.setCharacterEncoding("UTF-8");
String uId_Session = (String)session.getAttribute("uId_Session");
String multiFlag = request.getParameter("multiFlag");

%>
<%
 
if (multiFlag.equals("s")) {
	
	//  삭제 버튼으로 회원목록 제거
	int rtnCnt = mMgr.mtd_Del(mBean);
	if (rtnCnt == 1) {
		response.sendRedirect("/Member/MemList.jsp");
	} else {
		// 예외처리 필요	
	}
	 
} else if(multiFlag.equals("m")) {
	
	 String [] num = request.getParameterValues("num"); 
	
/* 	int numVal = mBean.getNum();
	String [] num = new String[numVal]; */
   int rtnCnt = mMgr.mtd_MultiDel(num);
	 if (rtnCnt > 0) {
		response.sendRedirect("/Member/MemList.jsp");
	} else {
		// 예외처리 필요
		
   }
	
}
%>