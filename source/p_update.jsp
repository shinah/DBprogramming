<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head><title>수강신청 교수 정보 수정</title>
	<link rel="stylesheet" type="text/css" href='mystyle.css' />
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
	
	String pSQL = null;
	ResultSet prs = null;
	Statement pstmt = null;

	if (session_id==null) {
		%>
	}
	<script>
		alert("로그인 해주세요.");
		location.href = "login.jsp";
	</script> 
	<%
	}
	else { 
		try{
			myConn = DriverManager.getConnection(dburl, user, passwd);
			pstmt=myConn.createStatement();

		}catch(SQLException e){
		    out.println(e);
		    e.printStackTrace();
		}
		pSQL = "select * from professor p where p.p_id='"+session_id+"'";
		prs = pstmt.executeQuery(pSQL);
		
			if( prs != null && prs.next()){
					String p_name = prs.getString("p_name");
					String p_pwd = prs.getString("p_pwd");
					String p_addr = prs.getString("p_addr");
					
					%>
					<form method="post" action="p_update_verify.jsp">
					<table width="75%" align="center" id = "update">
					 <tr><th>교수번호</th>
					 <td><input type = "text" name = "p_id" size = "20" value = "<%= session_id %>" id="update_id_name" style="background-color: #e2e2e2;" readonly>
					 </td></tr>
					 <tr><th>이름</th>
					 <td><input type = "text" name = "p_name" size = "20" value = "<%= p_name %>" id="update_id_name" style="background-color: #e2e2e2;" readonly>
					 </td></tr>
					 <tr><th>주소</th>
					 <td><input type = "text" name = "p_addr" size = "50" value = "<%= p_addr %>" id="update_pwd_addr">
					 </td></tr>
					 <tr><th>비밀번호</th>
					 <td><input type = "password" name = "p_pwd" size = "20" value = "<%= p_pwd %>" id="update_pwd_addr">
					 </td></tr>
					 
					 <%
					 }
						pstmt.close();
					 	myConn.close();
				}
				 %>

				<td colspan=4><div align="center">
				<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="수정" id = "button">
				<INPUT TYPE="RESET" VALUE="취소" id="button">
				</div></td>
				</tr>



				</table></form></body></html>