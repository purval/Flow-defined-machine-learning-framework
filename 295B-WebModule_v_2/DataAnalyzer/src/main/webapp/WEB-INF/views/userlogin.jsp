<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="utf-8" />
<title>FDCSD - Login</title>

<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link href="<c:url value="/resources/css/bootstrap.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/animate.css"  />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/font-awesome.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/icon.css"  />" rel="stylesheet">
<link href="<c:url value="/resources/css/font.css"  />" rel="stylesheet">
<link href="<c:url value="/resources/css/app.css"  />" rel="stylesheet">
<script src="<c:url value="/resources/js/go.js" />"></script>
<link href="<c:url value="/resources/css/generic.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<style>
.custome_bg {
	background: #1aae88;
}
</style>

</head>

<body align="center">
	<section class="vbox"> <br></br>
	<c:url var="url" value="/login" /> <form:form
		modelAttribute="userAttribute" method="POST" action="${url}">
		<p class="text1">
			Machine Learning framework designed to run different types of
			algorithm flows. <br></br> Get Started !!!
		</p>
		<fieldset align="center">
			<h3>USER LOGIN</h3>
			<c:if test="${not empty error}">
   				Error: ${error}
			</c:if>
			<br>
			<div style="width:400px; margin:auto;"><p>
				<table class="table">
					<tr>
					<td><label><B>Email ID :</B></label></td>
					<td><input name="email" type="text" placeholder="jone@abc.com" /></td>
					</tr>
					<tr>
					<td><label><B>password :</B></label></td>
					<td><input name="password" type="password" placeholder="********" /></td>
					</tr>
				</table>
			</p></div>
			<p>
				<button id="login" class="btn btn-success" type="submit" >Login</button>
			</p>
			<br>
			<p>
				<a href="./registrationpage" ><h4><u>New User? <i>register here!!!</i></u></h4></a>
			</p>
		</fieldset>
	</form:form>

	<div class="navbar navbar-custom navbar-fixed-bottom custome_bg"
		role="navigation">Semiconductor Fault Detection Analysis.
		Copyrights: Structfish 2015</div>
</section>
</body>
</html>
