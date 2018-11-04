<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title>
		<link rel="stylesheet" type="text/css" href='mystyle.css' /></head>
<body>
<% 
	
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	
	Connection myConn = null;	
	String pSQL = null;
	Statement pstmt = null;
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "db01";
	String session_id= (String)session.getAttribute("prof");
	String p_id = request.getParameter("p_id");
	String p_name = request.getParameter("p_name");
	String p_pwd = request.getParameter("p_pwd");
	//String p_addr = request.getParameter("p_addr");
	String p_addr = new String(request.getParameter("p_addr").getBytes("8859_1"),"utf-8");


	try{
		
		myConn = DriverManager.getConnection(dburl, user, passwd);
		pstmt = myConn.createStatement();
	}
	catch(Exception e){
		System.err.println("SQLException:" + e.getMessage());
	}
	pSQL = "update professor set p_pwd= '"+p_pwd+"', p_addr = '" + p_addr+"' where p_id='"+p_id + "'";
	try{
		pstmt.executeQuery(pSQL);
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
	location.href = "p_update.jsp";
</script>
<% } finally{
		if(pstmt!=null)
			try{
				pstmt.close(); 
				myConn.close();
			}		catch(SQLException ex){}
	}
%>
</body></html>
