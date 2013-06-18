<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.ConnectionController"%>
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.model.Article"%>
<%@page import="de.auctionhouse.utils.CurrencyHelper"%>

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
String articleId = request.getParameter("passId");
if (articleId != null) {
	int id = Integer.parseInt(articleId);
	
	ArticleController ac = ArticleController.sharedInstance();
	Article article = ac.findById(id);
	out.println("<p>" + article.getValue("id") + "</p>");
	out.println("<p>" + article.getValue("title") + "</p>");
	out.println("<p>" + article.getValue("description") + "</p>");
	out.println("<p>" + CurrencyHelper.toEuro(article.getValue("start_price")) + "&euro;</p>");
	out.println("<p>" + article.getValue("is_Direct_Buy") + "</p>");

	User seller = article.getRelation("seller", User.class);
	out.println("<p>" + seller.getValue("first_name") + "</p>");
} else {
	out.println("<p>Ungültiger Artikel.</p>");
}
%>



</body>
</html>