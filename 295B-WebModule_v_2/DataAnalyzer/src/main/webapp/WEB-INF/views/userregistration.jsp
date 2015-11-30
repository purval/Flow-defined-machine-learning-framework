<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="utf-8" />
<title>FDCSD - Registration</title>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link  href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/animate.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
<link  href="<c:url value="/resources/css/icon.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/app.css"  />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>
<script src="<c:url value="/resources/js/go.js" />"></script>


<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/generic.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<style>
.custome_bg {
	background:#1aae88;
}
</style>

</head>

<body align="center">

<section class="vbox">
<c:url var="saveUrl" value="/register" />
<form:form modelAttribute="userAttribute" method="POST" action="${saveUrl}">
       	<fieldset align="center">
                   <legend >REGISTRATION FOR NEW USER</legend>
                   	   <c:if test="${not empty error}">
   							Error: ${error}
					   </c:if>
		               <p>
		                   <label><B>Email ID :</B></label>
		                   <input name="email" type="text" placeholder="jone@abc.com"/>
		               </p>
		               <p>
		                   <label><B>User Name :</B></label>
		                   <input name="displayName" type="text" placeholder="jone"/>
		               </p>
		               <p>
		                   <label><B>password :</B></label>
		                   <input name="password" type="password" placeholder="********" />
		               </p>


				    <p>
					<input type="submit" value="Create" ></input>
					<button onclick="#">Cancel</button>
				    </p>
                                     </br>
		              <p>
		                   <label>Existing user, Please </label>
		                   <a href="./loginpage">login</a>
		               </p>
                    
          </fieldset>
</form:form>
<div class="navbar navbar-custom navbar-fixed-bottom custome_bg" role="navigation"> Semiconductor Fault Detection Analysis. Copyrights: Structfish 2015</div>
</section>
</body>
</html>
