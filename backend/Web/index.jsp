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
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

	<jsp:include page="header.jsp" />


<!--Datenbank auslesen-->
<%
	
	ArticleController ac = ArticleController.sharedInstance();
	List<Article> articles = ac.findAll();
	
	out.println("<table>");
	for (Article article : articles) {
		out.println("<a href=\"\"><tr><td>" + article.id + "</td><td>"
				+ article.title + "</td><td>" + article.description + "</td><td>"
				+ article.startPrice + "</td></tr></a>");
	}
	out.println("</table>");
	
/*
	try {
		Class.forName("org.postgresql.Driver");
	} catch (ClassNotFoundException e) {
		out.println("<h1>Driver not found:" + e + e.getMessage()
		+ "</h1>");
	}
	try {
		Connection conn = DriverManager.getConnection(
		"jdbc:postgresql:auctionhouse", "auctionhouse_root", "1234");

		Statement stmt = conn.createStatement();
		ResultSet rs;

		rs = stmt.executeQuery("SELECT * FROM article");

		out.println("<table>");
		while (rs.next()) {
	String veranstaltungid = rs.getString("id");
	String name = rs.getString("title");
	String creditpoints = rs.getString("seller_id");
	String dozentid = rs.getString("start_price");
	out.println("<tr><td>" + veranstaltungid + "</td><td>"
	+ name + "</td><td>" + creditpoints + "</td><td>"
	+ dozentid + "</td></tr>");
		}
		out.println("</table>");

		conn.close();
	} catch (Exception e) {
		out.println("<h1>exception: " + e + e.getMessage() + "</h1>");
	}
*/
%>

<!--Ueberprueft Formular auf Vollstaendigkeit-->
<script type="text/javascript"> 
function verifyForm(formular) { 
  if (formular.email.value == "") { 
    alert("Please enter e-mail"); 
    formular.name.focus(); 
    return false; 
  }
  if (formular.lastname.value == "") { 
    alert("Please enter a password"); 
    formular.lastname.focus(); 
    return false; 
  }
return true;
}
</script>
</body>
</html>