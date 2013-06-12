<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>

<h1>FOO</h1>
<%

	out.println(request.getParameter("email"));
	out.println(request.getParameter("password"));

/*
	UserController uc = UserController.sharedInstance();
	try {
		User user = uc.login(request.getParameter("email"), request.getParameter("password"));
	} catch(SQLException e) {
		
	}*/
%>

</body>
</html>