<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="utf-8" />
<title>FDCSD - Registration</title>

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
	<section class="vbox"> <c:url var="saveUrl" value="/register" />
	<form:form modelAttribute="userAttribute" method="POST"
		action="${saveUrl}">
		<fieldset align="center">
			<br><br><br>
			<h3>REGISTRATION FOR NEW USER</h3>
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
					<td><label><B>Display Name :</B></label></td>
					<td><input name="displayName" type="text" placeholder="jone" /></td>
					</tr>
					<tr>
					<td><label><B>password :</B></label></td>
					<td><input name="password" type="password" placeholder="********" /></td>
					</tr>
				</table>
			</p></div>
			<p>
				<button id="login" class="btn btn-success" type="submit" >Register</button>
			</p>
			<br>
			<p>
				<a href="./loginpage" ><h4><u>Existing user? <i>login here!!!</i></u></h4></a>
			</p>
		</fieldset>
	</form:form>
	<div class="navbar navbar-custom navbar-fixed-bottom custome_bg"
		role="navigation">Semiconductor Fault Detection Analysis.
		Copyrights: Structfish 2015</div>
</section>
</body>
</html>
