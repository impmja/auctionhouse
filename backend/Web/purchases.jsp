<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.PurchasesController"%>
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.Article"%>
<%@page import="de.auctionhouse.model.Purchase"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.utils.CurrencyHelper"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>My Purchases</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body><div id="wrapper">
	
	<jsp:include page="header.jsp" />

		<%
			PurchasesController pc = PurchasesController.sharedInstance();
			UserController uc = UserController.sharedInstance();
			User user = uc.getLoggedIn(request);
			
 			if (user != null) {
 				int userId = Integer.parseInt(user.getValue("id"));
 			
				int counter = 1;
			
				out.println("<table>");
				for (Purchase purchase : pc.findAllByUserId(userId)) {
					Article article = purchase.getRelation("article", Article.class);
					out
							.println("<form id=\""
									+ counter
									+ "\" action=\"auction.jsp\" method=\"post\"><tr id=\""
									+ (counter % 2 == 0 ? "even_tr" : "odd_tr")
									+ "\" ><td><a href=\"javascript: submitform("
									+ counter
									+ ")\">"
									+ article.getValue("title")
									+ "</a></td><td><a href=\"javascript: submitform("
									+ counter
									+ ")\">"
									+ article.getValue("description")
									+ "</a></td><td><a href=\"javascript: submitform("
									+ counter
									+ ")\">"
									+ CurrencyHelper.toEuro(purchase.getValue("price"))
									+ "&euro;</a></td></tr><input type=\"hidden\" name=\"articleId\" value="
									+ article.getValue("article_id") + "></form>");
					counter++;
				}
				out.println("</table>");
 			}
		%>
		
		<!--Fuehrt Forumlar mit entsprechender ID aus-->
		<script type="text/javascript"> 
		function submitform(_id) {
		  document.getElementById(_id).submit();
		}
		</script>
</div>
	</body>
</html>