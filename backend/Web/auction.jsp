<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.ConnectionController"%>
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.model.Article"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>eBay 2.0 - <%= request.getParameter("passId") %></title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<jsp:include page="header.jsp" />

<%
String test = request.getParameter("passId");
int id = Integer.parseInt(test);
%>

<%
ArticleController ac = ArticleController.sharedInstance();
Article article = ac.findById(id);
out.println("<p>" + article.id + "</p>");
out.println("<p>" + article.title + "</p>");
out.println("<p>" + article.description + "</p>");
out.println("<p>" + article.startPrice + "</p>");
out.println("<p>" + article.isDirectBuy + "</p>");
out.println("<p>" + article.seller + "</p>");
%>

<div id="bid_panel">
	<form action="auction.jsp" method="post">
		<input type="text" name="bid">
		<input type="submit" name="buy" value="Bid">
	</form>
</div>


</body>
</html>