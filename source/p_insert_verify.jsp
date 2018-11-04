<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*, java.text.*" %>
<html>
<head>
<title>수강 신청 입력</title>
</head>
<body>
<% 
   request.setCharacterEncoding("utf-8");
   String dbdriver = "oracle.jdbc.driver.OracleDriver"; 
   Class.forName(dbdriver);
   Connection myConn = null; 
   
   String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
   String user="db01";  
   String passwd="db01";
     
   String result = null; 
   int sh,eh;
   double sm,em;
   double s_time,e_time;

   sh = Integer.parseInt(request.getParameter("c_st_h")); 
   sm= Integer.parseInt(request.getParameter("c_st_m"));
   sm = sm/60;
   s_time = sh+sm;
   eh = Integer.parseInt(request.getParameter("c_et_h"));
   em = Integer.parseInt(request.getParameter("c_et_m"));
   em=em/60;
   e_time = eh+em;

   Statement stmt = null, stmt1 = null; ResultSet rs = null, rs1 = null;
   CallableStatement cstmt = null, cstmt1 = null;

   PreparedStatement pstmt = null, pstmt1 = null;
   String sql = null;
   Boolean check = false;
   int c_id_no = 0;
   
   String c_name = request.getParameter("c_name");
   String id = request.getParameter("id");
   int c_unit = Integer.parseInt(request.getParameter("c_unit"));
   int c_max = Integer.parseInt(request.getParameter("c_max"));
   String c_room = request.getParameter("c_room");
   int c_day = Integer.parseInt(request.getParameter("c_day"));

   try {
      Class.forName(dbdriver);
         myConn =  DriverManager.getConnection (dburl, user, passwd);
         stmt = myConn.createStatement();
         
         sql = "select c_id, c_id_no from course where c_name = '" + c_name+"'";
         rs = stmt.executeQuery(sql);
         if(rs != null) {
            String c_id = null;
            while(rs.next()){
               c_id = rs.getString("c_id");
               check = true;
               c_id_no = Integer.parseInt(rs.getString("c_id_no"));
            }

            if(check == false){
               String cc_id = null; int n_id;
               stmt1 = myConn.createStatement();
               sql = "select c_id from course";
               rs1 = stmt1.executeQuery(sql);
               while(rs1.next())
                  c_id = rs1.getString("c_id");
               cc_id = c_id.substring(1); n_id = Integer.parseInt(cc_id) + 1; out.print(n_id);
               c_id_no = 0; c_id = "M" + n_id;
               out.print(c_id + " " + c_id_no);
            }
         System.out.println(c_name+'\t'+c_unit+'\t'+id+'\t'+c_id+'\t'+c_id_no+'\t'+c_id_no+'\t'+s_time+'\t'+e_time+'\t'+c_max);
         cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?)}");  
         cstmt.setString(1, c_name);
         cstmt.setInt(2, c_unit);
         cstmt.setString(3, id);
         cstmt.setString(4, c_id);
         cstmt.setInt(5,c_id_no+1);
         cstmt.setString(6,c_room);
         cstmt.setInt(7,c_day);
         cstmt.setDouble(8,s_time);
         cstmt.setDouble(9,e_time);
         cstmt.setInt(10,c_max);
         cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
         cstmt.execute();
         
         result = cstmt.getString(11);
         %>
         <script>
            alert("<%=result%>");
           location.href="p_insert.jsp";
         </script>
         <%
         }
        }
   catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
    }
    finally {
             if (pstmt != null) 
                  try { 
                     pstmt.close();
                     pstmt1.close();
                     cstmt.close();
                     
                  }catch(SQLException ex) { 
                     out.print("에러");
                  }
              if(stmt != null){
                 try{
                    stmt.close();
                 }catch(SQLException ex) { 
                     out.print("에러");
                  }
              }
              myConn.close();
          }%>
</body>
</html>