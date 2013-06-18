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
	<title>eBay 2.0</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<jsp:include page="header.jsp" />


<!--Datenbank auslesen und Verlinkungen setzen-->
<%
	
	ArticleController ac = ArticleController.sharedInstance();
	List<Article> articles = ac.findAll();
	
	int counter = 1;
	
	out.println("<table>");
	for (Article article : articles) {
		out.println("<form id=\"" + counter + "\" action=\"auction.jsp\" method=\"post\"><tr><td><a href=\"javascript: submitform(" + counter +")\">" 
				+ article.getValue("id") + "</a></td><td><a href=\"javascript: submitform(" + counter +")\">"
				+ article.getValue("title") + "</a></td><td><a href=\"javascript: submitform(" + counter +")\">"
				+ article.getValue("description") + "</a></td><td><a href=\"javascript: submitform(" + counter +")\">"
				+ article.getValue("start_price") + "</a></td></tr><input type=\"hidden\" name=\"passId\" value=" 
				+ article.getValue("id") + "></form>");
		counter++;
	}
	out.println("</table>");
%>

<!--Fuehrt Forumlar mit entsprechender ID aus-->
<script type="text/javascript"> 
function submitform(_id)
{
  document.getElementById(_id).submit();
}
</script>
</body>
</html>