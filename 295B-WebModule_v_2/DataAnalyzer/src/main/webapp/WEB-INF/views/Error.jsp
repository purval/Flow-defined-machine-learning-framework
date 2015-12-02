<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Error Page</title>

<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link href="<c:url value="/resources/css/bootstrap.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/animate.css"  />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/font-awesome.min.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/icon.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/font.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/app.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/generic.css" />"
	rel="stylesheet">

<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>


<style>
body {
	color: black;
}

.custome_bg {
	background: #1aae88;
}
</style>
</head>
<body>
	<header
		class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow custome_bg">
	<div class="navbar-header aside-md dk">
		<a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen"
			data-target="#nav"> <i class="fa fa-bars"></i>
		</a> <a href="#" class="navbar-brand"><img
			src="/dataanalyzer/resources/images/logo.png" class="m-r-sm"
			alt="scale"> <span class="hidden-nav-xs">FDCSD</span> </a> <a
			class="btn btn-link visible-xs" data-toggle="dropdown"
			data-target=".user"> <i class="fa fa-cog"></i>
		</a>
	</div>
	</header>
	<aside class="bg-light lter b-r">
	<div class="wrapper">
		<section class="panel no-border lt">
		<div class="row m-t-xl" style="margin: 0px;">
			<div class="col-sm-12">
				<div class="panel-body">

					<div class="tab-content">
						<div class="form-group">
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-8">
									<div class="progress progress-xs m-t-md">
										<div class="progress-bar bg-success" style="width: 100%;"></div>
									</div>
								</div>
								<div class="col-md-2"></div>
							</div>	
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-7">									
									<c:if test="${not empty Error}">
   		   								<label>${Error}</label> 
									</c:if> <c:if test="${empty Error}">
   		   								<label>Something went bad!!</label> 
									</c:if>
								</div>
								<div class="col-md-3"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	</aside>
</body>
</html>
