<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head>
<title>교수 수강신청 취소</title>
      <link rel="stylesheet" type="text/css" href='mystyle.css' />
</head>
<body>
<%@ include file="top.jsp" %>
<%     
if (session_id == null) 
response.sendRedirect("login.jsp");

Connection myConn = null;      
Statement stmt = null;
CallableStatement cstmt = null;
String mySQL = "";
String semesterSQL = "";
ResultSet myResultSet = null;

String dburl  = "jdbc:oracle:thin:@localhost:1521:orcl";
String user="db01";     
String passwd="db01";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
int sh,eh;
double sm,em;
String sm2,em2;
String c_day2="";

int presentSemester = 0;
try {
   Class.forName(dbdriver);
    myConn =  DriverManager.getConnection (dburl, user, passwd);
   stmt = myConn.createStatement();   
} catch(SQLException ex) {
   System.err.println("SQLException: " + ex.getMessage());
}

%>
<table width="75%" align="center" id = "delete">
      <br>
      <tr>
         <th>과목번호</th>
         <th>분반</th>
         <th>과목명</th>
         <th>수업시간</th>
         <th>강의실</th>
          <th>수업취소</th>
      </tr>
<%

mySQL = "select t.c_id, t.c_id_no, c.c_name, t.c_day,t.c_stime, t.c_etime, t.c_room from course c, teach t, professor p where p.p_id='"+ session_id +"' and t.p_id = p.p_id and c.c_id = t.c_id and t.c_id_no = c.c_id_no";
try{
   myResultSet = stmt.executeQuery(mySQL);
   if (myResultSet != null) {
      while (myResultSet.next()) {   
         String c_id = myResultSet.getString("c_id");
         int c_id_no = myResultSet.getInt("c_id_no");         
         String c_name = myResultSet.getString("c_name");
         int c_day = myResultSet.getInt("c_day");
         if (c_day == 1){ c_day2 = "월"; }
         else if (c_day == 2){ c_day2 = "화";}
         else if (c_day == 3){c_day2 = "수";}
         else if (c_day == 4){c_day2 = "목";}
         else if (c_day == 5){c_day2 = "금";}
         else {c_day2 = "토";}
         double c_stime = myResultSet.getDouble("c_stime");
         double c_etime = myResultSet.getDouble("c_etime");
           sh = (int)c_stime;
           sm = (c_stime-sh)*60;
           if (sm == 0){
              sm2 = "00";
           }
           else{
              sm2 = Integer.toString((int)sm);
           }
           eh = (int)c_etime;
           em = (c_etime-eh)*60;
           if (em ==0){
              em2 = "00";
           }
           else{
              em2 = Integer.toString((int)em);
           }

           String c_room = myResultSet.getString("c_room");
         
         %>            
         <tr>
           <td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td> 
           <td align="center"><%= c_name %></td>
           <td align="center"><%= c_day2 %> <%= sh %>:<%= sm2 %> ~ <%= eh %>:<%= em2 %></td>
           <td align="center"><%= c_room %></td>
           <td align="center"><a id="click" href="p_delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">취소</a></td>
         </tr>
<%
      }
   }
}catch(SQLException e){
    out.println(e);
    e.printStackTrace();
}
stmt.close();  
myConn.close();
%>
</table></body></html>
</body>
</html>