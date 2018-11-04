<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html><head><title> 수강신청 취소 </title></head>
<body>

<%
	Connection myConn = null;    String	result = null;	
	String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user="db01";   String passwd="db01";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	CallableStatement cstmt;

	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	} catch(SQLException ex) {
    	 System.err.println("SQLException: " + ex.getMessage());
	}
	
	boolean stu_mode = true;
	
	String session_id= (String)session.getAttribute("user");
	String s_id = (String)session.getAttribute("user");
	String c_id = request.getParameter("c_id");
	int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));		

    cstmt = myConn.prepareCall("{call DeleteEnroll(?,?,?)}");
	cstmt.setString(1, s_id);
	cstmt.setString(2, c_id);
	cstmt.setInt(3,c_id_no);
	try  {  	
		cstmt.execute();	
%>
	<script>	
		alert("취소되었습니다."); 
		location.href="delete.jsp";
	</script>
<%
		} catch(SQLException ex) {		
			 System.err.println("SQLException: " + ex.getMessage());
		}  
		finally {
		    if (cstmt != null) 
	            try { myConn.commit(); cstmt.close();  myConn.close(); }
	 	      catch(SQLException ex) { }
	     }

%>
</form></body></html>
