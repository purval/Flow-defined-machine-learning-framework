<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" />
<title>FDCSD - Experiment</title>

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<link  href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/animate.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
<link  href="<c:url value="/resources/css/icon.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/font.css"  />" rel="stylesheet">
<link  href="<c:url value="/resources/css/app.css"  />" rel="stylesheet">
<link href="<c:url value="/resources/css/generic.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/custom.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/dataTables.bootstrap.min.css" />" rel="stylesheet">

<script src="<c:url value="/resources/js/jquery-2.1.4.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.dataTables.min.js" />"></script>
<script src="<c:url value="/resources/js/dataTables.bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/go.js" />"></script>
<script src="<c:url value="/resources/js/flowchart.js" />"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>

</head>
<body onload="init()">
<input type="hidden" id="jsonBom" value='${process_flow}'/>
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


<div id="mlflow" class="container-fluid">
  <div class="row" id="frow">
    <div class="col-md-3" style="margin: 10px 0px 10px 10px;">
    <table><tr><td><a id="home" href="http://localhost:8080/dataanalyzer/"><img alt="new" class="img-rounded" src="http://localhost:8080/dataanalyzer/resources/images/home.png" width="30" height="32"/></a></td>
    <td><h5>&nbsp Experiment: 
	<c:if test="${not empty experiment_name}">
  		   ${experiment_name}
	</c:if>
	<c:if test="${empty experiment_name}">
  		   NO_NAME
	</c:if>
	</h5></td></tr></table>
	</div>
    <div class="col-md-6" style="margin: 10px 0px 10px 30px;">
      <button id="save" type="button" class="btn btn-primary" onclick="save()" style="margin-left:20px">Save</button>
      <button id="load" type="button" class="btn btn-warning" onclick="reset()">Reset</button>
      <button id="run" type="button" class="btn btn-danger">Run</button>
      <!-- <button id="delete" type="button" class="btn btn-danger">Delete</button> 
      <button id="new" type="button" class="btn btn-danger">New</button> -->
      <a id="new" href="#" style="margin-left:220px" data-toggle="modal" data-target="#newEx"><img alt="new" class="img-rounded" src="http://localhost:8080/dataanalyzer/resources/images/new.png" width="30" height="32"/></a>
      <a id="delete" href="#" style="margin-left:10px"><img alt="delete" class="img-rounded" src="http://localhost:8080/dataanalyzer/resources/images/delete.png" width="30" height="32"/></a>
    </div>
    <div class="col-md-2" style="margin: 10px 0px 10px 50px;">
    	<button type="button" class="btn btn-primary">Visualization</button>
    	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#help">Help</button> 
    </div>
  </div>
  
  <div class="row">
    <div class="col-md-3">
    	<div >
    		<!-- <img alt="new" class="img-rounded" src="../resources/images/click.png" width="25" height="19"/> --> 
        	<div class="sidemenu" id="dataset" data-toggle="modal" data-target="#fileUploader">
        	<h4>Upload DataSet</h4></div>
        	<div class="sidemenu" id="fs" data-toggle="modal" data-target="#fSelector"><h4>Feature Selection</h4></div>
        	<div class="sidemenu" id="parameters" data-toggle="modal" data-target="#paramSetter"><h4>Parameter Setting</h4></div> 
        	<div class="sidemenu" id="algo"><h4> ML Algorithms </h4></div>
        	<div id="palleteDiv"></div>
        </div>
    </div>
    <div class="col-md-6">
        <div id="myDiagram" class="divStyle"></div>
    </div>
    <div class="col-md-3">
        <div id="status" class="divStyle">
          <div style="padding: 2px 20px;"><h4>Process Status</h4></div>
        </div>
    </div>
  </div>

  <div style="width:100%; white-space:nowrap;">
    
  </div>
  
    <!-- File upload Modal -->
	<div class="modal fade" id="fileUploader" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Upload DataSet</h4>
	      </div>
	      <div class="modal-body">
	        	<form id="datasetform" enctype="multipart/form-data"> 
				    <div>
				 		<input id="datasetfile" type="file" name="dataset" required/>
				    </div>   
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button id="datasetButton" class="btn btn-success" name="datasetbutton">Upload</button>
	      </div>
	    </div>
	  </div>
	</div>
  
	<!-- Feature seletion Modal -->
	<div class="modal fade" id="fSelector" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Select Features</h4>
	      </div>
	      <div class="modal-body">
	        	<div id="fsdiv"> 
				    
				</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button id="fsButton" class="btn btn-success" name="fsbutton">Save</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  	<!--Parameter setting Modal -->
	<div class="modal fade" id="paramSetter" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Parameter Setting</h4>
	      </div>
	      <div class="modal-body">
	        	<form id="psform"> 
				   
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button id="psButton" class="btn btn-success" name="psButton">Save</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  	<!-- New Experiment Modal -->
	<div class="modal fade" id="newEx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Create New Experiment</h4>
	      </div>
	      <c:url var="url" value="/newexperiment" />
	      <form id="neform" method="POST" action="${url}">
		      <div class="modal-body">
					    <label for="exName"><h4>Experiment Name</h4></label>
						<input id="exName" type="input" name="experiment_name"/>				
						<!-- <button id="newEx" class="btn btn-success" type="submit" >New Experiment</button> -->
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <button id="newEx" class="btn btn-success" name="nexbutton" type="submit">Create</button>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>
  
  	<!-- Help Modal -->
	<div class="modal fade" id="help" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Help!</h4>
	      </div>      
	      <div class="modal-body">
				
				help: instructions to use FDCSD machine learning tool.
					
	      </div>
	    </div>
	  </div>
	</div>

  <textarea id="mySavedModel" style="width:100%;height:300px" hidden>
  { "class": "go.GraphLinksModel",
  "linkFromPortIdProperty": "fromPort",
  "linkToPortIdProperty": "toPort",
  "nodeDataArray": [
  {"key":-1, "category":"Start", "loc":"175 -150", "text":"Start"},

  {"key":-2, "category":"End", "loc":"175 50", "text":"End!"}
  ],
  "linkDataArray": [

  ]} 
  </textarea>
 
 <!--  <button onclick="makeSVG()">Render as SVG</button>
  <div id="SVGArea"></div> -->
</div>
</body>
</html>
