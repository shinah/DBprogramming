<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head>
	<title>수강신청 사용자 정보 수정</title>
	<link rel='stylesheet' href='mystyle.css' />
</head>
<body>
<%@ include file="top.jsp" %>

<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "db01";
	
	String mySQL = null;
	ResultSet rs = null;
	Statement stmt = null;

	if (session_id==null) { %>
	<script>
		alert("로그인 해주세요.");
		location.href = "login.jsp";
	</script> 
	

<% } else{
		try{
			
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		}
		catch(Exception e){
			System.err.println("SQLException:"+e.getMessage());
		}
		
		mySQL = "select s_name, s_addr, s_pwd from student where s_id='" + session_id + "'" ; 
		rs = stmt.executeQuery(mySQL);
		
		if(rs != null &&rs.next()){
			String s_name = rs.getString("s_name");
			String s_addr = rs.getString("s_addr");
			String s_pwd = rs.getString("s_pwd");
	
	%>
	
	<form method="post" action="update_verify.jsp">
	
	<table width="75%" align="center" height="100%" id = "update" >
	
	 <tr><th>학   번</th>
	 <td><input type = "text" name = "s_id" value = "<%= session_id %>" id="update_id_name" style="background-color: #e2e2e2;" readonly>
	 </td></tr>
	 <tr><th>이   름</th>
	 <td><input type = "text" name = "s_name" value = "<%= s_name %>" id="update_id_name" style="background-color: #e2e2e2;"  readonly>
	 </td></tr>
	 <tr><th>주   소</th>
	 <td><input type = "text" name = "s_addr" value = "<%= s_addr %>" id="update_pwd_addr" >
	 </td></tr>
	 <tr><th>비밀번호</th>
	 <td><input type = "password" name = "s_pwd" value = "<%= s_pwd %>" id="update_pwd_addr" >
	 </td></tr>
	 
	 <%
	 }
		stmt.close();
	 	myConn.close();
}
 %>

	<td colspan=4><div align="center">
	<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="수정" id="button">
	<INPUT TYPE="RESET" VALUE="취소" id="button">
	</div></td>
	</tr>
	</table>
	</form>
</body>
</html>