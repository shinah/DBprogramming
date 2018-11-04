<%@ page contentType="text/html; charset=utf-8" %>
<%
	boolean stu_mode = true;
	String user_name = (String)session.getAttribute("user_name");
	String session_id= (String)session.getAttribute("user");
	if(session_id == null) {
		session_id = (String)session.getAttribute("prof");
		if(session_id != null) stu_mode = false;
	}
	String log;

	if (session_id==null)
		log="<a href=login.jsp id=menu_fcolor> 로그인</a>";
	else
		log="<a href = logout.jsp id=menu_fcolor> 로그아웃</a>";
%>
<a href="main.jsp" align="center"></a>
<table width="75%" align="center">

			<td align="left"><img src="image/long.gif" width = "200"/></td>
	<% if (session_id != null) { %>
		<tr>
			<td align="right">접속자 : <%=user_name%></td>
		</tr>
		<%} %>
<table width="75%" align="center" id = "nav_menu">
	<tr>
	<td align="center" id = "menu_fcolor"><b><%=log%></b></td>

<%	if( stu_mode == false ) {
%>
	<td align="center"><b><a href="p_update.jsp" id="menu_fcolor">사용자 정보 수정</b></td>
	<td align="center"><b><a href="p_insert.jsp" id="menu_fcolor">수업과목 추가</b></td>
	<td align="center"><b><a href="p_delete.jsp" id="menu_fcolor">수업과목 삭제</b></td>
	<td align="center"><b><a href="p_select.jsp" id="menu_fcolor">수업과목 조회</b></td>
	
<%  }
	else {
%>
	<td align="center"><b><a href="update.jsp" id="menu_fcolor">사용자 정보 수정</b></td>
	<td align="center"><b><a href="insert.jsp" id="menu_fcolor">수강과목 신청</b></td>
	<td align="center"><b><a href="delete.jsp" id="menu_fcolor">수강과목 취소</b></td>
	<td align="center"><b><a href="select.jsp" id="menu_fcolor">수강과목 조회</b></td>
<%  }
%>

</tr>
</table>