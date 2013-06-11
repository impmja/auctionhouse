<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" %>
<%@ page import="java.util.*" %>

<%
String name = "";
String lastname = "";
String street = "";
String number = "";
String postalcode = "";
String town = "";
String country = "";
String mail = "";
String password = "";

// Wenn das Formular abgeschickt wurde
if (request.getParameter("name") != null)
{
   name  = request.getParameter("name");
   lastname = request.getParameter("lastname");
   street = request.getParameter("street");
   number = request.getParameter("number");
   postalcode = request.getParameter("postalcode");
   town = request.getParameter("town");
   country = request.getParameter("country");
   mail = request.getParameter("mail");
   password = request.getParameter("password");
}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div id="header">eBay 2.0
	<div id="form">
		<p><input name="email" type="text" size="20" value="E-Mail"></p>
		<p><input name="password" type="password" size="20" value="******"></p>
		<input type="button" name="login" value="Login"> <input type="button" name="registrieren" value="Register">
	</div>
</div>


<!--Eigentliches Formular-->
<div id="content">
<h1>Register</h1>
<form action="form.jsp" method="post" onsubmit="return verifyForm(this);">
  <p>First Name: <input name="name" type="text" size="30" id="name"></p>
  <p>Last Name: <input name="lastname" type="text" size="30" id="lastname"></p>
  <br>
  <p>Street: <input name="street" type="text" size="30" id="street"> <input name="number" type="text" size="3" id="number"></p>
  <p>Postal Code: <input name="postalcode" type="text" size="5" id="postalcode"></p>
  <p>Town: <input name="town" type="text" size="30" id="town"></p>
  <p>Country: <input name="country" type="text" size="30" id="country"></p>
  <br>
  <p>E-Mail: <input name="mail" type="text" size="30" id="mail"></p>
  <p>Password: <input name="password" type="password" size="20" id="password"></p>
  <br>
  <p><input type="Submit" value="Submit" name="submit"><input type="Reset" value="Reset" name="reset"> </p>
</form>
</div>


<!--Ueberprueft Formular auf Vollstaendigkeit-->
<script type="text/javascript"> 
function verifyForm(formular) { 
  if (formular.name.value == "") { 
    alert("Please enter your first name"); 
    formular.name.focus(); 
    return false; 
  }
  if (formular.lastname.value == "") { 
    alert("Please enter your last name"); 
    formular.lastname.focus(); 
    return false; 
  }
  if (formular.street.value == "") { 
    alert("Please enter street"); 
    formular.street.focus(); 
    return false; 
  }
  if (formular.number.value == "") { 
    alert("Please enter street number"); 
    formular.number.focus(); 
    return false; 
  }
  if (formular.postalcode.value == "") { 
    alert("Please enter postal code"); 
    formular.postalcode.focus(); 
    return false; 
  }
  if (formular.town.value == "") { 
    alert("Please enter town"); 
    formular.town.focus(); 
    return false; 
  }
  if (formular.country.value == "") { 
    alert("Please enter country"); 
    formular.country.focus(); 
    return false; 
  }
  if (formular.mail.value == "") { 
    alert("Please enter your E-Mail adress"); 
    formular.mail.focus(); 
    return false; 
  }
  if (formular.password.value == "") { 
    alert("Please enter a password"); 
    formular.password.focus(); 
    return false; 
  }
  
  return true; 
}
</script> 
</body>
</html>