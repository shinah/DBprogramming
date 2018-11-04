<%@ page contentType="text/html; charset=utf-8" %>
<html><head>
	<style type="text/css">
	</style>
	<title>데이터베이스를 활용한 수강신청 시스템 입니다.</title>
	<link rel="stylesheet" type="text/css" href='mystyle.css' />

<body>
<%@ include file="top.jsp" %>
	<table width="75%" align="center" height="50%">
	<% if (session_id != null) { %>
	<tr>
		<td align="center"><%=user_name%>님 방문을 환영합니다.</td>
	</tr>
	<% }
	else { %>
	<tr>
		<td align="center">로그인한 후 사용하세요.</td>
	</tr>
	<%
	}
	%>
	</table>
</body>
</html>