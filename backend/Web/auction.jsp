<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.ConnectionController"%>
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.controller.CommentController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.model.Article"%>
<%@page import="de.auctionhouse.utils.CurrencyHelper"%>
<%@page import="de.auctionhouse.model.Image" %>
<%@page import="de.auctionhouse.model.Comment" %>

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
<div id="container">

<%
String articleIdStr = request.getParameter("passId");
if (articleIdStr != null) {
	int articleId = Integer.parseInt(articleIdStr);
	
	ArticleController ac = ArticleController.sharedInstance();
	Article article = ac.findById(articleId);
	out.println("<div id=\"detail_panel\"><p>" + article.getValue("id") + "</p>");
	out.println("<p>" + article.getValue("title") + "</p>");
	out.println("<p>" + article.getValue("description") + "</p>");
	out.println("<p>" + CurrencyHelper.toEuro(article.getValue("start_price")) + "&euro;</p>");
	//out.println("<p>" + article.getValue("is_Direct_Buy") + "</p>");

	User seller = article.getRelation("seller", User.class);
	out.println("<p>" + seller.getValue("first_name") + "</p></div>");
	
	Image image = article.getRelation("image", Image.class);
	out.println("<img src=\"img\\" + image.getValue("uri") + "\"</img></div>");
	
	
	// TODO: In Footer packen
	CommentController cc = CommentController.sharedInstance();
	out.println("<div id=\"comments_panel\">");
	for (Comment comments : cc.findAll(articleId, 4)) {
		out.println("<div id=\"comment_entry\">");
		User user = comments.getRelation("user", User.class);
		out.println("<div id=\"comment_entry_user\"><p>" + user.getValue("first_name") + "&nbsp;" + user.getValue("last_name") + "</p>");
		out.println("<p>" + comments.getValue("comment") + "</p></div>");
	}
	out.println("<div\">");
	
} else {
	out.println("<p>Ungültiger Artikel.</p></div>");
}
%>
<div id="bid_panel">
	<form action="auction.jsp" method="post">
		<input type="text" name="bid">
		<input type="submit" name="buy" value="Bid">
	</form>
</div>
</div>

</body>
</html>