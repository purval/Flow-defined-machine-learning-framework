<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" />
<title>FDCSD - Homepage</title>

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
<script src="<c:url value="/resources/js/home.js" />"></script>


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

	<ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">
		<li class="dropdown"><a href="#" class="dropdown-toggle"
			data-toggle="dropdown"> <span class="thumb-sm avatar pull-left">
					<img src="/dataanalyzer/resources/images/a0.png" alt="Image">
			</span> <c:if test="${not empty user}">
   		   ${user.displayName}
		</c:if> <c:if test="${empty user}">
   		   user
		</c:if> <b class="caret"></b>
		</a>
			<ul class="dropdown-menu animated fadeInRight">
				<li><a href="#">Profile</a></li>
				<li class="divider"></li>
				<li><a href="http://localhost:8080/dataanalyzer/logout" data-toggle="ajaxModal">Logout</a></li>
			</ul></li>
	</ul>
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
								<div class="col-md-8">
									<table class="table">
										<tr>
											<td>
												<c:url var="url" value="/newexperiment" />
												<form method="POST"
													action="${url}">
													<table>
														<tr><td><label for="exName"><h4>Experiment Name</h4></label></td></tr>
														<tr><td><input id="exName" class="form-control" type="input" name="experiment_name"  style="margin-bottom: 10px" required/></td></tr>
														<tr><td>
															<button id="newEx" class="btn btn-success btn-large"
															type="submit" >New Experiment</button>
														</td></tr>
													</table>
												</form>
											</td>
											<td>
												<table>
													<tr><td><label for="list"><h4>My Experiments List</h4></label></td></tr>
													<tr><td><br><br></td></tr>
													<tr><td>
														<button id="myExp" class="btn btn-large btn-success"
														type="button">My Experiments</button>
													</td></tr>
												</table>
											</td>
											<td>
												<table>
													<tr><td><label for="visual"><h4>My Visualizations</h4></label></td></tr><tr><td><br><br></td></tr>
													<tr><td>
														<button type="button" class="btn btn-primary">View</button>
													</td></tr>
												</table>
											</td>
										<tr>
									</table>
								</div>
								<div class="col-md-2"></div>
							</div>
							<hr>
							<div class="row">
								<div class="col-md-2"></div>
								<div class="col-md-7">
									<div id="experiments" style="margin: 0 0 0 160px"></div>
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
