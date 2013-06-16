<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@ page language="java" import="java.sql.*"%>



<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div id="header">eBay 2.0	
<%
	// Login request?
	UserController uc = UserController.sharedInstance();
	if (request.getParameter("is_login") != null) {
		try {
			User user = uc.login(request);
			if (user == null) {
				out.println("Invalid Login!");
			}
		} catch(SQLException e) {
			out.println("Invalid Login!");
		}		
	}

	// find logged in user
	try {
		User user = uc.getLoggedIn(request);
		if (user != null) {
			out.println("<p>Sie sind angemeldet als: " + user.email + "</p>");	
		} else { %>
			<div id="form">
				<form action="index.jsp" method="post">
				<p><input name="email" type="text" size="20" value="E-Mail" onclick="this.value='';"
				onblur="this.value=!this.value?'E-Mail':this.value;"></p>
				<p><input name="password" type="password" size="20" value="******" onclick="this.value='';"
				onblur="this.value=!this.value?'******':this.value;"></p>
				<input type="submit" name="login" value="Login">
				<input type="hidden" name="is_login">
				</form>
		
				<form action="form.jsp" method="post">
					<input type="submit" name="register" value="Register">
				</form>
			</div>
		<%	}
	} catch(SQLException e) {
		out.println("Fehler: Kein User");
	}
%>
</div>
</body>
</html>