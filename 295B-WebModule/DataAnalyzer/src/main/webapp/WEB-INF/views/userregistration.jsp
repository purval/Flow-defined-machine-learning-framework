<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta charset="utf-8" />
<title>Data Analyses tool</title>

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

  <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow custome_bg">
    <div class="navbar-header aside-md dk"> <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i class="fa fa-bars"></i> </a> <a href="home.html" class="navbar-brand"><img src="<c:url value="/resources/images/logo.png"/>" class="m-r-sm" alt="scale"/> <span class="hidden-nav-xs">Fault Detection</span> </a> <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user"> <i class="fa fa-cog"></i> </a> </div>
    <ul class="nav navbar-nav hidden-xs">
      <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="i i-grid"></i> </a>
        <section class="dropdown-menu aside-lg bg-white on animated fadeInLeft">
          <div class="row m-l-none m-r-none m-t m-b text-center">
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-mail i-2x text-primary-lt"></i> </span> <small class="text-muted">Mailbox</small> </a> </div>
            </div>
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-calendar i-2x text-danger-lt"></i> </span> <small class="text-muted">Calendar</small> </a> </div>
            </div>
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-map i-2x text-success-lt"></i> </span> <small class="text-muted">Map</small> </a> </div>
            </div>
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-paperplane i-2x text-info-lt"></i> </span> <small class="text-muted">Trainning</small> </a> </div>
            </div>
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-images i-2x text-muted"></i> </span> <small class="text-muted">Photos</small> </a> </div>
            </div>
            <div class="col-xs-4">
              <div class="padder-v"> <a href="#"> <span class="m-b-xs block"> <i class="i i-clock i-2x text-warning-lter"></i> </span> <small class="text-muted">Timeline</small> </a> </div>
            </div>
          </div>
        </section>
      </li>
    </ul>
    <form class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search">
      <div class="form-group">
        <div class="input-group"> <span class="input-group-btn">
          <button type="submit" class="btn btn-sm bg-white b-white btn-icon"><i class="fa fa-search"></i></button>
          </span>
          <input type="text" class="form-control input-sm no-border" placeholder="Search apps, projects...">
        </div>
      </div>
    </form>
    <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
      <li class="hidden-xs"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="i i-chat3"></i> <span class="badge badge-sm up bg-danger count">2</span> </a>
        <section class="dropdown-menu aside-xl animated flipInY">
          <section class="panel bg-white">
            <div class="panel-heading b-light bg-light"> <strong>You have <span class="count">2</span> notifications</strong> </div>
            <div class="list-group list-group-alt"> <a href="#" class="media list-group-item"> <span class="pull-left thumb-sm"> <img src="<c:url value="/resources/images/a0.png"/>" class="img-circle" alt=""/> </span> <span class="media-body block m-b-none"> Use awesome animate.css<br>
              <small class="text-muted">10 minutes ago</small> </span> </a> <a href="#" class="media list-group-item"> <span class="media-body block m-b-none"> 1.0 initial released<br>
              <small class="text-muted">1 hour ago</small> </span> </a> </div>
            <div class="panel-footer text-sm"> <a href="#" class="pull-right"><i class="fa fa-cog"></i></a> <a href="#notes" data-toggle="class:show animated fadeInRight">See all the notifications</a> </div>
          </section>
        </section>
      </li>
      <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span class="thumb-sm avatar pull-left"> <img src="<c:url value="/resources/images/a0.png"/>" alt="Image"/> </span> Karuna <b class="caret"></b> </a>
        <ul class="dropdown-menu animated fadeInRight">
          <li> <span class="arrow top"></span> <a href="#">Settings</a> </li>
          <li> <a href="profile.html">Profile</a> </li>
          <li> <a href="#"> <span class="badge bg-danger pull-right">3</span> Notifications </a> </li>
          <li> <a href="docs.html">Help</a> </li>
          <li class="divider"></li>
          <li> <a href="modal.lockme.html" data-toggle="ajaxModal" >Logout</a> </li>
        </ul>
      </li>
    </ul>
  </header>




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
<div class="navbar navbar-custom navbar-fixed-bottom custome_bg" role="navigation"> Semiconductor Fault Detection Analysis. Copyrights: Structfish 2015</div>
</section>
</body>
</html>
