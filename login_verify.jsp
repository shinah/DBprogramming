<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title></title>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "db01";
	//String id = null, pw = null;
	PreparedStatement stmt = null;	PreparedStatement p_stmt = null;
	String mySQL = null;	String p_mySQL = null;
	ResultSet rs = null; 	ResultSet p_rs = null;
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
%>
</head>
<body>
<%
	try{
		myConn = DriverManager.getConnection(dburl, user, passwd);
		mySQL = "select s_id, s_pwd, s_name from student where s_id=? and s_pwd=?";
		stmt = myConn.prepareStatement(mySQL); 
		stmt.setString(1,userID);
		stmt.setString(2,userPassword);
		rs = stmt.executeQuery();
		p_mySQL = "select p_id, p_pwd, p_name from professor where p_id=? and p_pwd=?";
		p_stmt = myConn.prepareStatement(p_mySQL); 
		p_stmt.setString(1,userID);
		p_stmt.setString(2,userPassword);
		p_rs = p_stmt.executeQuery();
	}catch(SQLException e){
	    out.println(e);
	    e.printStackTrace();
	}finally{
		if(rs != null && p_rs != null){
			if (rs.next()) {
			String u_name = rs.getString("s_name");
			session.setAttribute("user_name", u_name);
			session.setAttribute("user", userID);
%>
				<script> 
					alert("로그인 성공!"); 
					location.href="main.jsp";  
				</script>
<%
			}
			else if (p_rs.next()) {
			String u_name = p_rs.getString("p_name");
			session.setAttribute("user_name", u_name);
			session.setAttribute("prof", userID);
%>
				<script> 
					alert("로그인 성공!"); 
					location.href="main.jsp";  
				</script>
<%
			}
			else {
%>
				<script> 
					alert("아이디/패스워드를 확인하세요."); 
					location.href="login.jsp";  
				</script>  
<%
			}
		}	
		stmt.close(); p_stmt.close();
		myConn.close();
	}
%>
</body>
</html>