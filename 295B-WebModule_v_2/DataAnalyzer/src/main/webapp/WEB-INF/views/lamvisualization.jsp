<%@page import="com.mongodb.DBObject"%>
<%@page import="com.mongodb.BasicDBList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" />
<title>FDCSD - Visualization</title>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link  href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/animate.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
<link  href="<c:url value="/resources/css/icon.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/app.css"  />" rel="stylesheet">
<link href="<c:url value="/resources/css/generic.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/ajax.js" />"></script>
<script src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="http://www.amcharts.com/lib/3/serial.js"></script>
<script src="http://www.amcharts.com/lib/3/themes/light.js"></script>

<style>
.custome_bg {
	background:#1aae88;
}

#chartdiv {
	width	: 100%;
	height	: 500px;
}

#selectiondd {
  margin: auto;
  width: 90%;
}

.inline { 
	display: inline-block; 
  margin:10px;
}

#home{
  margin-right:10px;
}
</style>
</head>
<body>

<header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow custome_bg">
  <div class="navbar-header aside-md dk"> <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i class="fa fa-bars"></i> </a> <a href="#" class="navbar-brand"><img src="/dataanalyzer/resources/images/logo.png" class="m-r-sm" alt="scale"> <span class="hidden-nav-xs">FDCSD</span> </a> <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user"> <i class="fa fa-cog"></i> </a> </div>

  <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
    <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
    <span class="thumb-sm avatar pull-left"> <img src="/dataanalyzer/resources/images/a0.png" alt="Image"> </span>
      <c:if test="${not empty user}">
       ${user.displayName}
  </c:if>
  <c:if test="${empty user}">
       user
  </c:if>
  <b class="caret"></b> </a>
      <ul class="dropdown-menu animated fadeInRight">
        <li> <a href="#">Profile</a> </li>
        <li class="divider"></li>
        <li> <a href="http://localhost:8080/dataanalyzer/logout" data-toggle="ajaxModal">Logout</a> </li>
      </ul>
    </li>
  </ul>
</header>

<div class="container-fluid">
  <div class="row"> 
    <div class="col-md-2"></div>
    <div class="col-md-8">
      <br>
      <div class="row">
        <div class="col-md-2"><a id="home" href="http://localhost:8080/dataanalyzer/"><img alt="new" class="img-rounded" src="http://localhost:8080/dataanalyzer/resources/images/home.png" width="30" height="32"/></a> </div>
        <div class="col-md-8"><div id="selectiondd">
          <select id="chamberUL">
              <option val="#" selected>Select Chamber</option>
                <option val="PM1">PM1</option>
                <option val="PM2">PM2</option>
                <option val="PM3">PM3</option>
                <option val="PM4">PM4</option>
          </select>
          
          <select id="dateUL">
            <option val="#" selected>Select Date</option>
            
          </select>
          <select id="fileUL">
            <option val="#" selected>Select File</option>
          </select>
        
          <select id="attributeUL">
            <option val="#" selected>Select Attribute</option>
          </select>
        </div>
        <div class="col-md-2"></div>
      </div>  
      <div id="chartdiv"></div>               
    </div>
    <div class="col-md-2"></div>
  </div> 
</div> 
</body>
</html>
