<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
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
<link href="<c:url value="/resources/css/generic.css" />" rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>
<script src="<c:url value="/resources/js/go.js" />"></script>

<style>
.custome_bg {
	background:#1aae88;
}
</style>

<script type="text/javascript">
document.getElementById("myExp").onclick = function () {
    document.location.href = "./fileupload";
};
</script>

</head>
<body>




<section class="vbox">
  <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow custome_bg">
    <div class="navbar-header aside-md dk"> <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i class="fa fa-bars"></i> </a> <a href="home.html" class="navbar-brand"><img src="<c:url value="/resources/images/logo.png"/>" class="m-r-sm" alt="scale"/> <span class="hidden-nav-xs">Fault Detection</span> </a> <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user"> <i class="fa fa-cog"></i> </a> </div>
   
    
<div>

<form class="navbar-form navbar-left">
  <input type="text" class="input-large search-query">
  <button  type="submit"  class="btn btn-small btn-primary navbar-right">Search</button>
</form>
</div>
    <ul class="nav navbar-nav navbar-right m-n hidden-xs nav-user user">

      <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span class="thumb-sm avatar pull-left"> <img src="<c:url value="/resources/images/a0.png"/>" alt="Image"/> </span> User <b class="caret"></b> </a>
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
  <section>
    <section class="hbox stretch">
      <!-- .aside -->
      <aside class="bg-black aside-md hidden-print" id="nav">
        <section class="vbox">
          <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railOpacity="0.2">
              <div class="clearfix wrapper dk nav-user hidden-xs">
                <div class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span class="thumb avatar pull-left m-r"> <img src="<c:url value="/resources/images/a0.png"/>" class="dker" alt="..."/> <i class="on md b-black"></i> </span> <span class="hidden-nav-xs clear"> <span class="block m-t-xs"> <strong class="font-bold text-lt">ANALYSIS</strong> <b class="caret"></b> </span> <span class="text-muted text-xs block">Machine Learning</span> </span> </a>
                  <ul class="dropdown-menu animated fadeInRight m-t-xs">
                    <li> <span class="arrow top hidden-nav-xs"></span> <a href="#">Settings</a> </li>
                    <li> <a href="profile.html">Profile</a> </li>
                    <li> <a href="#"> <span class="badge bg-danger pull-right">3</span> Notifications </a> </li>
                    <li> <a href="docs.html">Help</a> </li>
                    <li class="divider"></li>
                    <li> <a href="modal.lockme.html" data-toggle="ajaxModal" >Logout</a> </li>
                  </ul>
                </div>
              </div>
              <!-- nav -->
              <nav class="nav-primary hidden-xs">
                <div class="text-muted text-sm hidden-nav-xs padder m-t-sm m-b-sm">Start</div>
                <ul class="nav nav-main" data-ride="collapse">
                  <li > <a href="index.html" class="auto"> <i class="i i-statistics icon"> </i> <span class="font-bold">Overview</span> </a> </li>
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <b class="badge bg-danger pull-right">4</b> <i class="i i-stack icon"> </i> <span class="font-bold">Visualizations</span> </a>

                  </li>
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-lab icon"> </i> <span class="font-bold">Flow Graph</span> </a>

                  </li>
                  <li  class="active"> <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-docs icon"> </i> <span class="font-bold">Details</span> </a>
                    <ul class="nav dk">
                      <li  class="active"> <a href="profile.html" class="auto"> <i class="i i-dot"></i> <span>Experiment</span> </a> </li>
                      <li > <a href="invoice.html" class="auto"> <i class="i i-dot"></i> <span>Dataset Selection</span> </a> </li>
                      <li > <a href="intro.html" class="auto"> <i class="i i-dot"></i> <span>Column Slection</span> </a> </li>
                      <li > <a href="master.html" class="auto"> <i class="i i-dot"></i> <span>Target Selection</span> </a> </li>
                      <li > <a href="gmap.html" class="auto"> <i class="i i-dot"></i> <span>Choose Algorithms</span> </a> </li>
                      <li > <a href="jvectormap.html" class="auto"> <i class="i i-dot"></i> <span>Draw Analysis</span> </a> </li>
                      <li > <a href="signin.html" class="auto"> <i class="i i-dot"></i> <span>Signin</span> </a> </li>
                      <li > <a href="signup.html" class="auto"> <i class="i i-dot"></i> <span>Signup</span> </a> </li>
                    </ul>
                  </li>

                </ul>
               
              </nav>
              <!-- / nav -->
            </div>
          </section>
             </section>
      </aside>
      <!-- /.aside -->
      <section id="content">
        <section class="vbox">
          <section class="scrollable">
            <section class="hbox stretch">
              <aside class="bg-light lter b-r">
                <section class="vbox">
                  <section class="scrollable">
                    <div class="wrapper">
                      <section class="panel no-border bg-primary lt" style="background:#FFFFFF;">
                      <div class="panel-body">
                        <div class="row m-t-xl" style="margin:0px;">
                          <div id="sample" class="flow_chat">
                            <div class="col-sm-12">
                               <div class="panel-body">
                                <div class="line line-lg"></div>
                                <div class="label-big"> Steps for Analysis..... </div>
                                <div class="progress progress-xs m-t-md">
                                  <div class="progress-bar bg-success" style="width: 100%;"></div>
                                </div>
                                <div class="tab-content">
                                <div id="step1" class="tab-pane active">
                                  <div class="form-group">
                                    <label class="col-sm-2 label-sm"><Strong>Choose a type!</Strong></label>
                                    <div class="col-sm-10">
                                  <p>
                                      <button id="myExp" class="btn btn-large btn-success" type="button">My Experiments</button>
                                        </p>
                                      <p>
                                        <button id="myExp" class="btn btn-success btn-large" type="button" onclick="location.href='./fileupload'" >New Experiment</button>
                                           </p>
                                    </div>
                                    </div>
                              </div>
                              </div>


                        </div>

                      </div>
                    </div>
                    </div>
                    </section>
                    </div>
                  </section>
                </section>
              </aside>

        </section>
      </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen" data-target="#nav"></a> </section>
</section>
</section>
</section>
<script src="js/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="js/bootstrap.js"></script>
<!-- App -->
<script src="js/app.js"></script>
<script src="js/slimscroll/jquery.slimscroll.min.js"></script>
<script src="js/charts/easypiechart/jquery.easy-pie-chart.js"></script>
<script src="js/app.plugin.js"></script>
</body>
</html>
