<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title></head>
<body>
<% 
	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	
	Connection myConn = null;	
	String mySQL = null;
	Statement stmt = null;
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "db01";
	
	String s_id = request.getParameter("s_id");
	String s_pwd = request.getParameter("s_pwd");
	//String s_addr = request.getParameter("s_addr");
	String s_addr = new String(request.getParameter("s_addr").getBytes("8859_1"),"utf-8");

	try{
		
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
	}
	catch(Exception e){
		System.err.println("SQLException:" + e.getMessage());
	}
	mySQL = "update student set s_pwd= '"+s_pwd+"', s_addr = '" + s_addr+"' where s_id='"+s_id + "'";
	try{
		stmt.executeQuery(mySQL);
%>
<script>
	alert("정보가 수정되었습니다.");
	location.href="main.jsp";
</script>
<%
	} catch(SQLException ex) {
  	  String sMessage;
   	  if (ex.getErrorCode() == 20002)
   		  sMessage="암호는 4자리 이상이어야 합니다";
	  else if (ex.getErrorCode() == 20003)
		  sMessage="암호에 공란은 입력되지 않습니다.";
	  else 
		  sMessage="잠시 후 다시 시도하십시오";	
%>
<script>
	alert("<%=sMessage%>");
	location.href = "update.jsp";
</script>
<% } finally{
		if(stmt!=null)
			try{
				stmt.close(); 
				myConn.close();
			}		catch(SQLException ex){}
	}
%>
</body></html>
