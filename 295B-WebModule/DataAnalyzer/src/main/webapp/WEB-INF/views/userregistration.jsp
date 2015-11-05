<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="utf-8" />
<title>Data Analyses tool</title>

<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/generic.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>


</head>
<body align="center">
<nav class="navbar navbar-custom">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Fault Detection Analysis</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Structfish <span class="sr-only">(current)</span></a></li>
        <li><a href="#">Hi User</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">My Account</a></li>
            <li><a href="#">My History</a></li>
            <li><a href="#">My Jukebox</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">One more separated link</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-left" role="search">
        <div class="form-group">
          <input type="text" class="form-control" placeholder="Search">
        </div>
        <button type="submit" class="btn btn-default">Submit</button>
      </form>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">About</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">My Account</a></li>
            <li><a href="#">My History</a></li>
            <li><a href="#">My Jukebox</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>


     <marquee>  </marquee>

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
<div class="navbar navbar-custom navbar-fixed-bottom" role="navigation"> Semiconductor Fault Detection Analysis. Copyrights: Structfish 2015</div>
</body>
</html>