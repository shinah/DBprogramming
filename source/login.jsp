<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
	<head><title>수강신청 시스템 로그인</title></head>
	<link rel='stylesheet' href='mystyle.css' />
	<BODY>
	<table width="75%" align="center">
	<tr><td><div align="center"> <img src="image/box.gif" width = "200" /></table>
	<table width="75%" align="center" bgcolor="#0070E8" id = "login_notice">
		<tr><td><div align="center"> 아이디와 비밀번호를 입력하세요</table>
		<table width="40%" align="center" id="login">
			<FORM method="post" action="login_verify.jsp" > 
			<tr><td ><div width="10" align="center" >아이디</div></td>
			<td><div align="center"><input type="text" name="userID"></div></td>
			</tr>
			<tr><td style="padding-top:10px"><div width="10" align="center">비밀번호</div></td>
			<td><div align="center"><input type="password" name="userPassword">
			</div></td>
			</tr>
			<tr>
			<td colspan=2 style="padding-top:20px"><div align="center" >
			<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인" id="button">
			<INPUT TYPE="RESET" VALUE="취소" OnClick="javascript:history.back(-1)" id="button">
			</div></td>
			</tr>
		</table>
		</FORM>
	</BODY> 
</HTML>