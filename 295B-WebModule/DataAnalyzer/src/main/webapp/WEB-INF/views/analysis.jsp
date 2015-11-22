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
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
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
</head>
<body>




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
                    <ul class="nav dk">
                      <li > <a href="layout-color.html" class="auto"> <i class="i i-dot"></i> <span>Color option</span> </a> </li>
                      <li > <a href="layout-hbox.html" class="auto"> <i class="i i-dot"></i> <span>Hbox layout</span> </a> </li>
                      <li > <a href="layout-boxed.html" class="auto"> <i class="i i-dot"></i> <span>Boxed layout</span> </a> </li>
                      <li > <a href="layout-fluid.html" class="auto"> <i class="i i-dot"></i> <span>Fluid layout</span> </a> </li>
                    </ul>
                  </li>
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-lab icon"> </i> <span class="font-bold"></span> </a>
                    <ul class="nav dk">
                      <li > <a href="buttons.html" class="auto"> <i class="i i-dot"></i> <span>Buttons</span> </a> </li>
                      <li > <a href="icons.html" class="auto"> <b class="badge bg-info pull-right">369</b> <i class="i i-dot"></i> <span>Icons</span> </a> </li>
                      <li > <a href="grid.html" class="auto"> <i class="i i-dot"></i> <span>Grid</span> </a> </li>
                      <li > <a href="widgets.html" class="auto"> <b class="badge bg-dark pull-right">8</b> <i class="i i-dot"></i> <span>Widgets</span> </a> </li>
                      <li > <a href="components.html" class="auto"> <i class="i i-dot"></i> <span>Components</span> </a> </li>
                      <li > <a href="list.html" class="auto"> <i class="i i-dot"></i> <span>List group</span> </a> </li>
                      <li > <a href="#table" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-dot"></i> <span>Table</span> </a>
                        <ul class="nav dker">
                          <li > <a href="table-static.html"> <i class="i i-dot"></i> <span>Table static</span> </a> </li>
                          <li > <a href="table-datatable.html"> <i class="i i-dot"></i> <span>Datatable</span> </a> </li>
                        </ul>
                      </li>
                      <li > <a href="#form" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-dot"></i> <span>Form</span> </a>
                        <ul class="nav dker">
                          <li > <a href="form-elements.html"> <i class="i i-dot"></i> <span>Form elements</span> </a> </li>
                          <li > <a href="form-validation.html"> <i class="i i-dot"></i> <span>Form validation</span> </a> </li>
                          <li > <a href="form-wizard.html"> <i class="i i-dot"></i> <span>Form wizard</span> </a> </li>
                        </ul>
                      </li>
                      <li > <a href="chart.html" class="auto"> <i class="i i-dot"></i> <span>Chart</span> </a> </li>
                      <li > <a href="portlet.html" class="auto"> <i class="i i-dot"></i> <span>Portlet</span> </a> </li>
                      <li > <a href="timeline.html" class="auto"> <i class="i i-dot"></i> <span>Timeline</span> </a> </li>
                    </ul>
                  </li>
                  <li  class="active"> <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-docs icon"> </i> <span class="font-bold">Pages</span> </a>
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
                              <form action="" method="get" id="wizardform">
                                <div class="panel panel-default">
                                <div class="panel-heading">
                                  <ul class="nav nav-tabs font-bold">
                                    <li class="active"><a data-toggle="tab" href="#step1">Step 1</a></li>
                                    <li class=""><a data-toggle="tab" href="#step2">Step 2</a></li>
<!--                                     <li class=""><a data-toggle="tab" href="#step3">Step 3</a></li> -->

                                  </ul>
                                </div>
                                </div>
                                <div class="panel-body">
                                <div class="line line-lg"></div>
                                <div class="label-big"> Steps for Analysis..... </div>
                                <div class="progress progress-xs m-t-md">
                                  <div class="progress-bar bg-success" style="width: 100%;"></div>
                                </div>
                                
                                <div class="tab-content">
                                <div id="step1" class="tab-pane active">
                          <label class="text1"><h3>Select columns for your customized Analysis. Also choose one Target.</h3></label>
                           <div class="table-responsive">
                            <table class="table">
                               <tr class="active"> 
                                  <th class="active">Select</th>
								  <th class="active">Measures</th>
								  <th class="active">Target</th>
							  </tr>
                               <tr class=""> 
                                  <td class=""> Sensor 1</td>
								  <td class=""><input type="checkbox" value=""></input></td>
								  <td class=""><input type="radio" name="target" value=""></input></td>
							  </tr>
							   <tr class="active"> 
                                  <td class="active">Sensor 2</td>
								  <td class="active"><input type="checkbox" value=""></input></td>
								  <td class="active"><input type="radio" name="target" value=""></input></td>
							  </tr>
							  <tr class=""> 
                                  <td class=""> Sensor 3</td>
								  <td class=""><input type="checkbox" value=""></input></td>
								  <td class=""><input type="radio" name="target" value=""></input></td>
							  </tr>
							   <tr class="active"> 
                                  <td class="active">Sensor 4</td>
								  <td class="active"><input type="checkbox" value=""></input></td>
								  <td class="active"><input type="radio" name="target" value=""></input></td>
							  </tr>
                               <tr class=""> 
                                  <td class=""> Sensor 4</td>
								  <td class=""><input type="checkbox" value=""></input></td>
								  <td class=""><input type="radio" name="target" value=""></input></td>
							  </tr>
							   <tr class="active"> 
                                  <td class="active">Sensor 5</td>
								  <td class="active"><input type="checkbox" value=""></input></td>
								  <td class="active"><input type="radio" name="target" value=""></input></td>
							  </tr>		
                               <tr class=""> 
                                  <td class=""> Sensor 6</td>
								  <td class=""><input type="checkbox" value=""></input></td>
								  <td class=""><input type="radio" name="target" value=""></input></td>
							  </tr>
							   <tr class="active"> 
                                  <td class="active">Sensor 7</td>
								  <td class="active"><input type="checkbox" value=""></input></td>
								  <td class="active"><input type="radio" name="target" value=""></input></td>
							  </tr>								  					  
                            </table>
                            
                            
                            </div>
                              </div>
                            <div id="step2" class="tab-pane">
                           <label class="text1"> <h3>Values for precision </h3></label>
                           <div class="table-responsive">
                            <table class="table">
                               <tr class="active"> 
                                  <td class="active"><label>Split Percentage</label></td>
								  <td class="active">
								        <select>
										  <option value="50-50">50-50</option>
										  <option value="70-30">70-30</option>
										</select>
								  </td>

							  </tr>
							   <tr class="active"> 
                                  <td class="active">Missing Values Replacement</td>

								  <td class="active"><input type="text" name="custom" placeholder="0"></td>
							  </tr>
						      <tr class="active"> 
                                  <td class="active">Replace with</td>
                                  <td class="active">
								        <select>
										  <option value="Mean">Mean</option>
										  <option value="Median">Median</option>
										  <option value="Median">Custom Value</option>										  
										</select>
								  </td>

							  </tr>
                            </table>
                            </div>
                            </div>
                            </div>
                            </div>
                          </form>
                        </div>
                            <div id="step3" class="tab-pane">
<!--                            <div class="table-responsive"> -->
<!--                             <table class="table table-bordered"> -->
<!--                                <tr class="active">  -->
<!--                                   <th class="active">Algorithm</th> -->
<!-- 								  <th class="active">Select</th> -->
								 
<!-- 							  </tr> -->
<!--                                <tr class="">  -->
<!--                                   <td class="">PCA</td> -->
<!-- 								  <td class=""><input type="checkbox" value=""></input></td> -->
								 
<!-- 							  </tr> -->
<!-- 							  <tr class="active">  -->
<!--                                   <td class="">K-Means</td> -->
<!-- 								  <td class=""><input type="checkbox" value=""></input></td> -->
								  
<!-- 							  </tr> -->
<!-- 							  <tr class="">  -->
<!--                                   <td class="">SVM</td> -->
<!-- 								  <td class=""><input type="checkbox" value=""></input></td> -->
								  
<!-- 							  </tr> -->
<!-- 					          <tr class="active">  -->
<!--                                   <td class="">Knn</td> -->
<!-- 								  <td class=""><input type="checkbox" value=""></input></td> -->
								  
<!-- 							  </tr> -->
<!-- 						      <tr class="">  -->
<!--                                   <td class="">Logistic Regression</td> -->
<!-- 								  <td class=""><input type="checkbox" value=""></input></td> -->
								 
<!-- 							  </tr> -->
<!--                             </table> -->
                            
                            
<!--                             </div> -->
                            </div>
                         
                            <ul class="pager wizard m-b-sm">
                              <li style="display:none;" class="previous first"><a href="#">First</a></li>
                              <li class="previous"><a href="#">Previous</a></li>
                              <li style="display:none;" class="next last "><a href="#">Last</a></li>
                              <li class="next "><a href="#">Next</a></li>
                            </ul>
                          </div>
                          </form>
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
