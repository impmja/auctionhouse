<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
   String email = request.getParameter( "email" );
   session.setAttribute( "theMail", email );
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div id="header">eBay 2.0
	<div id="form">
	<%
	if ( session.getAttribute( "theMail" ) != null) { %>
		Sie sind angemeldet als: <% session.getAttribute( "theMail" ) ; 
	}
	else { %>
		<form action="SaveSession.jsp" method="post" onsubmit="return verifyForm(this);">
		<p><input name="email" type="text" size="20" value="E-Mail"></p>
		<p><input name="password" type="password" size="20" value="******"></p>
		<input type="submit" name="login" value="Login">
		</form>
		<form action="form.jsp" method="post">
		<input type="submit" name="register" value="Register">
		</form>
	</div>
	<% } %>
</div>


<!--Datenbank auslesen-->
<%
	try {
		Class.forName("org.postgresql.Driver");
	} catch (ClassNotFoundException e) {
		out.println("<h1>Driver not found:" + e + e.getMessage()
				+ "</h1>");
	}
	try {
		Connection conn = DriverManager.getConnection(
				"jdbc:postgresql:studdb_marth", "marth", "yxcv1234");

		Statement stmt = conn.createStatement();
		ResultSet rs;

		rs = stmt.executeQuery("SELECT * FROM veranstaltung");

		out.println("<table>");
		while (rs.next()) {
			String veranstaltungid = rs.getString("veranstaltungid");
			String name = rs.getString("name");
			String creditpoints = rs.getString("creditpoints");
			String dozentid = rs.getString("dozentid");
			out.println("<a href=\"http://www.ebay.de\"><tr><td>" + veranstaltungid + "</td><td>"
					+ name + "</td><td>" + creditpoints + "</td><td>"
					+ dozentid + "</td></tr></a>");
		}
		out.println("</table>");

		conn.close();
	} catch (Exception e) {
		out.println("<h1>exception: " + e + e.getMessage() + "</h1>");
	}
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