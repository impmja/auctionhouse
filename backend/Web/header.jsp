<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="de.auctionhouse.controller.UserController;"%>




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<div id="header">eBay 2.0
	<div id="form">
	<%
	if ( session.getAttribute( "theMail" ) != null) { %>
		Sie sind angemeldet als: <% session.getAttribute( "theMail" );
	}
	else { %>
		<form action="header.jsp" method="post" onsubmit="return verifyForm(this);">
		<p><input name="email" type="text" size="20" value="E-Mail" onclick="this.value='';"
		onblur="this.value=!this.value?'E-Mail':this.value;"></p>
		<p><input name="password" type="password" size="20" value="******" onclick="this.value='';"
		onblur="this.value=!this.value?'******':this.value;"></p>
		<input type="submit" name="login" value="Login">
		</form>
		<form action="form.jsp" method="post">
		<input type="submit" name="register" value="Register">
		</form>
	</div>
	<% } %>
</div>
</body>
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
</html>