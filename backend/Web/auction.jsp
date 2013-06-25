<%@page import="de.auctionhouse.controller.ArticleController"%>
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.controller.CommentController"%>
<%@page import="de.auctionhouse.controller.BidController"%>
<%@page import="de.auctionhouse.controller.PurchasesController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@page import="de.auctionhouse.model.Article"%>
<%@page import="de.auctionhouse.utils.CurrencyHelper"%>
<%@page import="de.auctionhouse.utils.TimeHelper"%>
<%@page import="de.auctionhouse.model.Image"%>
<%@page import="de.auctionhouse.model.Comment"%>
<%@page import="de.auctionhouse.model.Bid"%>
<%@page import="de.auctionhouse.model.Purchase"%>

<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.Date"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>eBay 2.0 - <%=request.getParameter("articleId")%></title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
	<div id="wrapper">
		<jsp:include page="header.jsp" />
		
		<div id="container">
		<%
			boolean bidError = false;
		
			String articleIdStr = request.getParameter("articleId");
			if (articleIdStr != null) {
				ArticleController ac = ArticleController.sharedInstance();
				UserController uc = UserController.sharedInstance();
				
				int articleId = Integer.parseInt(articleIdStr);
				Article article = ac.findById(articleId);
				
				User user = null;
				try {
					user = uc.getLoggedIn(request);
			
					// place bid?
					if (!TimeHelper.checkIfTimeIsOver(article.getValue("end_date"))) { 
						if (user != null && request.getParameter("place_bid") != null && request.getParameter("bid") != null) {
							try {
								int userId = Integer.parseInt(user.getValue("id"));
								ac.bidOnArticle(userId, articleId, CurrencyHelper.toCents(request.getParameter("bid")));
							} catch (Exception e) {
								bidError = true;
							}
						}
					} else {
						// ned to set the article as purchased?
						PurchasesController pc = PurchasesController.sharedInstance();
						try {
							pc.addPurchase(articleId);
						} catch (Exception e) {
							System.out.println(e.getMessage());
						}
					}
					
				} catch (SQLException e) {
		 			out.println("Fehler: Ungueltige Anmeldung.");
		 		}

				// show article
				out.println("<div id=\"detail_panel\">");
				out.println("<h3>" + article.getValue("title") + "</h3>");
				out.println("<p>" + article.getValue("description") + "<p><br>");
				
				//out.println("<p>" + article.getValue("is_Direct_Buy") + "</p>");
		
				Image image = article.getRelation("image", Image.class);
				out.println("<img src=\"img/" + image.getValue("uri")
						+ "\" width=\"300\" height=\"300\">");
				out.println("</div>");
				
		
				// Bid Panel
				out.println("<div id=\"bid_panel\">");
				
				User seller = article.getRelation("seller", User.class);
				out.println("<center><h4>Verk&auml;ufer:</h4><p>"
						+ seller.getValue("first_name") + "&nbsp;" + seller.getValue("last_name")
						+ "</p></center><br>");
				
				out.println("<p><center><h4>Startpreis:</h4><p>"
						+ CurrencyHelper.toEuro(article.getValue("start_price"))
						+ "&nbsp;&euro;</p></center></p><br>");
				
				
				// Check if the auction has ended
				if (TimeHelper.checkIfTimeIsOver(article.getValue("end_date"))) {
					
					PurchasesController pc = PurchasesController.sharedInstance();
					try {
						Purchase purchase = pc.findByArticleId(articleId);
						if (purchase != null) {
							User buyer = purchase.getRelation("user", User.class);
							
							out.println("<p><center><h4>Kaufpreis:</h4><p>"
									+ CurrencyHelper.toEuro(purchase.getValue("price"))
									+ "&nbsp;&euro;</p></center></p><br>");
							
							out.println("<center><h4>K&auml;ufer:</h4><p>"
									+ buyer.getValue("first_name") + "&nbsp;" + buyer.getValue("last_name")
									+ "</p></center><br>");	
						}
					} catch(SQLException e) {
						out.println("<center><h4>K&auml;ufer:</h4><p>"
								+ "Unbekannt."
								+ "</p></center><br>");	
					}
					
					out.println("<p><center><h4>Hinweis:</h4><p>"
							+ "Auktion ist beendet."
							+ "</p></center></p><br>");
					
				} else {

					BidController bc = BidController.sharedInstance();
					try {
						Bid lastBid = bc.findLastByArticleId(articleId);
						if (lastBid != null) {
							User bidder = lastBid.getRelation("bidder", User.class);
							out.println("<p><center><h4>Aktuelles Gebot:</h4><p>"
									+ CurrencyHelper.toEuro(lastBid.getValue("bid")) + "&nbsp;&euro;</p>"
									+ "<p>" + bidder.getValue("first_name") + "&nbsp;" + bidder.getValue("last_name") + "</p>"
									+ "</center></p><br>");
						} else {
							out.println("<p><center><h4>Aktuelles Gebot:</h4><p>"
									+ "Keins"
									+ "</p></center></p><br>");
						}
					} catch(SQLException e) {
						out.println("<p><center><h4>Aktuelles Gebot:</h4><p>"
								+ "Keins"
								+ "</p></center></p><br>");
					}
					
					out.println("<p><center><h4>Verbleibende Zeit:</h4><p>"
							+ TimeHelper.computeDifferenceAsString(article
									.getValue("end_date"))
							+ "</p></center></p><br>");
					
					if (user != null) {
					%>
					<form action="auction.jsp" method="post">
						<input id="bid_text" type="text" name="bid">
						<input type="hidden" name="place_bid">
						<input type="hidden" name="articleId" value="<%=request.getParameter("articleId")%>">
						<input id="bid_submit" type="submit" name="buy" value="Bieten">
					</form>
					<%
					} else {
						out.println("<p><center><h4>Hinweis:</h4><p>"
								+ "Zum Bieten bitte anmelden!"
								+ "</p></center></p><br>");
					}
					
					if (bidError) {
						out.println("<center><h5 id=\"invalid_bid\">Ungueltiges Gebot!</h5></center>");
					}
				}
				out.println("</div>");
				
				// Show Comments
				CommentController cc = CommentController.sharedInstance();
				out.println("<div id=\"comments_panel\"><h3>Kommentare</h3>");
				for (Comment comments : cc.findAll(articleId, 10)) {
					out.println("<div id=\"comment_entry\">");
					User commentUser = comments.getRelation("user", User.class);
					out.println("<div id=\"comment_entry_user\"><p><h4>"
							+ commentUser.getValue("first_name") + "&nbsp;"
							+ commentUser.getValue("last_name") + "</h4>");
					out.println(comments.getValue("comment") + "</p></div>");
				}
		
			} else {
				out.println("<p>Ungültiger Artikel.</p></div>");
			}
			%>
		</div></div>
	</body>
</html>