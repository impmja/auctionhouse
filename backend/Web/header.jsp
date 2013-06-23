<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="de.auctionhouse.controller.UserController"%>
<%@page import="de.auctionhouse.model.User"%>
<%@ page language="java" import="java.sql.*"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<div id="header">
			<div id="header_title"><h2><a href="index.jsp">eBay 2.0</a></h2></div>
			
		<%
			boolean invalidLogin = false;
		
		 	// Does the User wants to login?
		 	UserController uc = UserController.sharedInstance();
		 	if (request.getParameter("is_login") != null) {
		 		try {
		 			User user = uc.login(request);
		 			if (user == null) {
		 				invalidLogin = true;
		 			}
		 		} catch (SQLException e) {
		 			invalidLogin = true;
		 		}
		 	} else if (request.getParameter("is_logout") != null) {
		 		try {
		 			uc.logout(request);
		 		} catch (SQLException e) {
		 			out.println("<div id=\"header_loggedin_bar\">Fehler: Abmeldung fehlgeschlagen.</div>");
		 		}
		 	}
		
		 	// find logged in user
		 	try {
		 		User user = uc.getLoggedIn(request);
		 		if (user != null) {
		 			out.println("<div id=\"header_loggedin_bar\">Angemeldet als: "
		 					+ user.getValue("first_name") + "&nbsp;" + user.getValue("last_name") + "</div>");
				%>
					<div id="header_tool_bar">
						<form action="index.jsp" method="post">
							<input id="header_tool_bar_article_button" type="submit" value="Artikel">
						</form>
						
						<form action="purchases.jsp" method="post">
							<input id="header_tool_bar_article_button" type="submit" value="Eink&auml;ufe">
						</form>
						
						<form action="index.jsp" method="post">
							<input type="hidden" name="is_logout">
							<input id="header_tool_bar_article_button" type="submit" value="Abmelden">
						</form>
					</div>
					
				<%
				} else {
				%>
					<div id="header_login_bar">
						<form action="index.jsp" method="post">
							<input type="hidden" name="is_login">	
							<input id="header_login_bar_edit" name="email" type="text" size="20" value="E-Mail"
								onclick="this.value='';"
								onblur="this.value=!this.value?'E-Mail':this.value;">
							<input id="header_login_bar_edit"
								name="password" type="password" size="20" value="******"
								onclick="this.value='';"
								onblur="this.value=!this.value?'******':this.value;">
							<input id="header_tool_bar_article_button" type="submit" value="Anmelden">
						</form>
					</div>
				<%
					if (invalidLogin) {
					%>
						<div id="header_loggedin_bar">Fehler: Ung&uuml;tige Anmeldung.</div>
					<%	
					} else {
					%>
						<div id="header_loggedin_bar">&nbsp;</div>
					<%
					}
				%>
					<div id="header_tool_bar">
						<form action="index.jsp" method="post">
							<input id="header_tool_bar_article_button" type="submit" value="Artikel">
						</form>
					</div>
				<%
				}
		 	} catch (SQLException e) {
				//out.println("Fehler: Unbekannter Benutzer.");
			}
		%> 
		<script type="text/javascript"> 
			function logout() {
				document.is_login = null;
			}
		</script>
		</div>
	</body>
</html>