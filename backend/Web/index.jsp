<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.BidController"%>
<%@page import="de.auctionhouse.model.Article"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.model.Bid"%>
<%@page import="de.auctionhouse.utils.CurrencyHelper"%>
<%@ page language="java" import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>eBay 2.0</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
	
		<jsp:include page="header.jsp" />
		<%
			ArticleController ac = ArticleController.sharedInstance();
			BidController bc = BidController.sharedInstance();
		
			int counter = 1;
		
			out.println("<table>");
			try {
				for (Article article : ac.findAll()) {
					
					int articleId = Integer.parseInt(article.getValue("id"));
					User seller = article.getRelation("seller", User.class);
					Bid currentBid = bc.findLastByArticleId(articleId);
					String currentBidStr = "";
					if (currentBid != null) {
						currentBidStr = "<p>" + CurrencyHelper.toEuro(currentBid.getValue("bid")) + "&nbsp;&euro;</p>";
					}
					
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
									+ seller.getValue("first_name") + "&nbsp;" + seller.getValue("last_name")
									+ "</a></td><td><a href=\"javascript: submitform("
									+ counter
									+ ")\">"
									+ CurrencyHelper.toEuro(article.getValue("start_price")) + "&nbsp;&euro;</a>"
									+ currentBidStr
									+ "</td></tr><input type=\"hidden\" name=\"articleId\" value="
									+ article.getValue("id") + "></form>");
					
					
					counter++;
				}
			} catch (SQLException e) {
				out.println("Fehler: Abfrage konnte nicht bearbeitet werden.");
			}
			out.println("</table>");
			
			out.println("<div id=\"impressum\"><center>Copyright by Marvin Palser &amp; Jan Schulte</center></div>");
		%>
		
		<!--Fuehrt Forumlar mit entsprechender ID aus-->
		<script type="text/javascript"> 
		function submitform(_id) {
			document.getElementById(_id).submit();
		}
		</script>
	</body>
</html>