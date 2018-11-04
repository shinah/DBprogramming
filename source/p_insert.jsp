<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
	<head>
		<title>수강신청 입력</title>
		<link rel="stylesheet" type="text/css" href='mystyle.css' />
	</head>
<body>
<%@ include file="top.jsp" %>
<% 	
	request.setCharacterEncoding("utf-8");
	if (session_id==null) response.sendRedirect("login.jsp");  
%> 
		<table width="75%" align="center" id = "insert">
		<br>
			<tr>
				<th>과목명</th>
				<th>학점</th>
				<th>수업 시간</th>
				<th>강의실</th>
				<th>인원</th>
			    <th>강의 추가</th>
			</tr>
			<tr></tr><tr></tr><tr></tr>
			<tr></tr><tr></tr><tr></tr>
			<tr>	</tr>
			<form action="p_insert_verify.jsp?id=<%=session_id%>" method="post">
				<td align="center"><input type="text" name="c_name"></td>
				<td align="center"><input type="text" name="c_unit" value="3" style="width:50px"></td>
				<td align="center" style="width:110px">
						<select name="c_day"style="width:100px">
						    <option value=1>월요일</option>
						    <option value=2>화요일</option>
						    <option value=3>수요일</option>
						    <option value=4>목요일</option>
						    <option value=5>금요일</option>
						    <option value=6>토요일</option>
						</select>
						<input type="text" name="c_st_h" style="width:40px"> :	<input type="text" name="c_st_m" style="width:40px">
						-
						<input type="text" name="c_et_h" style="width:40px"> : <input type="text" name="c_et_m" style="width:40px">
				<td align="center"><input type="text" name="c_room" ></td>
				</td> 
				<td align="center"><input type="text" name="c_max" style="width:50px" ></td>
				<td align="center"><input type="submit" value="추가" id = "button"></td>
			</form>
			</tr>
			</table>