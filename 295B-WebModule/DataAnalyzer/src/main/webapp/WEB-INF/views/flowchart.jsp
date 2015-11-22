<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="commons.jsp"%>    
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
<script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();

            $('.datatable').dataTable();
			setSidebarHeight();


        });

  function init() {
    if (window.goSamples) goSamples();  // init for these samples -- you don't need to call this
    var $ = go.GraphObject.make;  // for conciseness in defining templates

    myDiagram =
      $(go.Diagram, "myDiagram",  // must name or refer to the DIV HTML element
        {
          initialContentAlignment: go.Spot.Center,
          allowDrop: true,  // must be true to accept drops from the Palette
          "LinkDrawn": showLinkLabel,  // this DiagramEvent listener is defined below
          "LinkRelinked": showLinkLabel,
          "animationManager.duration": 800, // slightly longer than default (600ms) animation
          "undoManager.isEnabled": true  // enable undo & redo
        });

    // when the document is modified, add a "*" to the title and enable the "Save" button
    myDiagram.addDiagramListener("Modified", function(e) {
      var button = document.getElementById("SaveButton");
      if (button) button.disabled = !myDiagram.isModified;
      var idx = document.title.indexOf("*");
      if (myDiagram.isModified) {
        if (idx < 0) document.title += "*";
      } else {
        if (idx >= 0) document.title = document.title.substr(0, idx);
      }
    });

    // helper definitions for node templates

    function nodeStyle() {
      return [
        // The Node.location comes from the "loc" property of the node data,
        // converted by the Point.parse static method.
        // If the Node.location is changed, it updates the "loc" property of the node data,
        // converting back using the Point.stringify static method.
        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
        {
          // the Node.location is at the center of each node
          locationSpot: go.Spot.Center,
          //isShadowed: true,
          //shadowColor: "#888",
          // handle mouse enter/leave events to show/hide the ports
          mouseEnter: function (e, obj) { showPorts(obj.part, true); },
          mouseLeave: function (e, obj) { showPorts(obj.part, false); }
        }
      ];
    }

    // Define a function for creating a "port" that is normally transparent.
    // The "name" is used as the GraphObject.portId, the "spot" is used to control how links connect
    // and where the port is positioned on the node, and the boolean "output" and "input" arguments
    // control whether the user can draw links from or to the port.
    function makePort(name, spot, output, input) {
      // the port is basically just a small circle that has a white stroke when it is made visible
      return $(go.Shape, "Circle",
               {
                  fill: "transparent",
                  stroke: null,  // this is changed to "white" in the showPorts function
                  desiredSize: new go.Size(8, 8),
                  alignment: spot, alignmentFocus: spot,  // align the port on the main Shape
                  portId: name,  // declare this object to be a "port"
                  fromSpot: spot, toSpot: spot,  // declare where links may connect at this port
                  fromLinkable: output, toLinkable: input,  // declare whether the user may draw links to/from here
                  cursor: "pointer"  // show a different cursor to indicate potential link point
               });
    }

    // define the Node templates for regular nodes

    var lightText = 'whitesmoke';

    myDiagram.nodeTemplateMap.add("",  // the default category
      $(go.Node, "Spot", nodeStyle(),
        // the main object is a Panel that surrounds a TextBlock with a rectangular Shape
        $(go.Panel, "Auto",
          $(go.Shape, "Rectangle",
            { fill: "grey", stroke: null },
            new go.Binding("figure", "figure")),
          $(go.TextBlock,
            {
              font: "bold 11pt Helvetica, Arial, sans-serif black",
              stroke: lightText,
              margin: 8,
              maxSize: new go.Size(160, NaN),
              wrap: go.TextBlock.WrapFit,
              editable: true
            },
            new go.Binding("text").makeTwoWay())
        ),
        // four named ports, one on each side:
        makePort("T", go.Spot.Top, false, true),
        makePort("L", go.Spot.Left, true, true),
        makePort("R", go.Spot.Right, true, true),
        makePort("B", go.Spot.Bottom, true, false)
      ));

    myDiagram.nodeTemplateMap.add("Start",
      $(go.Node, "Spot", nodeStyle(),
        $(go.Panel, "Auto",
          $(go.Shape, "Circle",
            { minSize: new go.Size(40, 40), fill: "#387C44", stroke: null }),
          $(go.TextBlock, "Start",
            { font: "bold 11pt Helvetica, Arial, sans-serif", stroke: lightText },
            new go.Binding("text"))
        ),
        // three named ports, one on each side except the top, all output only:
        makePort("L", go.Spot.Left, true, false),
        makePort("R", go.Spot.Right, true, false),
        makePort("B", go.Spot.Bottom, true, false)
      ));

    myDiagram.nodeTemplateMap.add("End",
      $(go.Node, "Spot", nodeStyle(),
        $(go.Panel, "Auto",
          $(go.Shape, "Circle",
            { minSize: new go.Size(40, 40), fill: "#DC3C00", stroke: null }),
          $(go.TextBlock, "End",
            { font: "bold 11pt Helvetica, Arial, sans-serif", stroke: lightText },
            new go.Binding("text"))
        ),
        // three named ports, one on each side except the bottom, all input only:
        makePort("T", go.Spot.Top, false, true),
        makePort("L", go.Spot.Left, false, true),
        makePort("R", go.Spot.Right, false, true)
      ));

    myDiagram.nodeTemplateMap.add("Comment",
      $(go.Node, "Auto", nodeStyle(),
        $(go.Shape, "File",
          { fill: "#EFFAB4", stroke: null }),
        $(go.TextBlock,
          {
            margin: 5,
            maxSize: new go.Size(200, NaN),
            wrap: go.TextBlock.WrapFit,
            textAlign: "center",
            editable: true,
            font: "bold 12pt Helvetica, Arial, sans-serif",
            stroke: '#454545'
          },
          new go.Binding("text").makeTwoWay())
        // no ports, because no links are allowed to connect with a comment
      ));


    // replace the default Link template in the linkTemplateMap
    myDiagram.linkTemplate =
      $(go.Link,  // the whole link panel
        {
          routing: go.Link.AvoidsNodes,
          curve: go.Link.JumpOver,
          corner: 5, toShortLength: 4,
          relinkableFrom: true,
          relinkableTo: true,
          reshapable: true,
          resegmentable: true,
          // mouse-overs subtly highlight links:
          mouseEnter: function(e, link) { link.findObject("HIGHLIGHT").stroke = "rgba(30,144,255,0.2)"; },
          mouseLeave: function(e, link) { link.findObject("HIGHLIGHT").stroke = "transparent"; }
        },
        new go.Binding("points").makeTwoWay(),
        $(go.Shape,  // the highlight shape, normally transparent
          { isPanelMain: true, strokeWidth: 8, stroke: "transparent", name: "HIGHLIGHT" }),
        $(go.Shape,  // the link path shape
          { isPanelMain: true, stroke: "gray", strokeWidth: 2 }),
        $(go.Shape,  // the arrowhead
          { toArrow: "standard", stroke: null, fill: "gray"}),
        $(go.Panel, "Auto",  // the link label, normally not visible
          { visible: false, name: "LABEL", segmentIndex: 2, segmentFraction: 0.5},
          new go.Binding("visible", "visible").makeTwoWay(),
          $(go.Shape, "RoundedRectangle",  // the label shape
            { fill: "#F8F8F8", stroke: null }),
          $(go.TextBlock, "Yes",  // the label
            {
              textAlign: "center",
              font: "10pt helvetica, arial, sans-serif",
              stroke: "#333333",
              editable: true
            },
            new go.Binding("text", "text").makeTwoWay())
        )
      );

    // Make link labels visible if coming out of a "conditional" node.
    // This listener is called by the "LinkDrawn" and "LinkRelinked" DiagramEvents.
    function showLinkLabel(e) {
      var label = e.subject.findObject("LABEL");
      if (label !== null) label.visible = (e.subject.fromNode.data.figure === "Diamond");
    }

    // temporary links used by LinkingTool and RelinkingTool are also orthogonal:
    myDiagram.toolManager.linkingTool.temporaryLink.routing = go.Link.Orthogonal;
    myDiagram.toolManager.relinkingTool.temporaryLink.routing = go.Link.Orthogonal;

    load();  // load an initial diagram from some JSON text

    // initialize the Palette that is on the left side of the page
    myPalette =
      $(go.Palette, "myPalette",  // must name or refer to the DIV HTML element
        {
          "animationManager.duration": 800, // slightly longer than default (600ms) animation
          nodeTemplateMap: myDiagram.nodeTemplateMap,  // share the templates used by myDiagram
          model: new go.GraphLinksModel([  // specify the contents of the Palette
            { category: "Start", text: "Start" },
            { text: "Step" },
            { text: "If", figure: "Diamond" },
            { category: "End", text: "End" },
            { category: "Comment", text: "Comment" }
          ])
        });

  }

  // Make all ports on a node visible when the mouse is over the node
  function showPorts(node, show) {
    var diagram = node.diagram;
    if (!diagram || diagram.isReadOnly || !diagram.allowLink) return;
    node.ports.each(function(port) {
        port.stroke = (show ? "white" : null);
      });
  }


  // Show the diagram's model in JSON format that the user may edit
  function save() {
    document.getElementById("mySavedModel").value = myDiagram.model.toJson();
    myDiagram.isModified = false;
  }
  function load() {
    myDiagram.model = go.Model.fromJson(document.getElementById("mySavedModel").value);
  }

  // add an SVG rendering of the diagram at the end of this page
  function makeSVG() {
    var svg = myDiagram.makeSvg({
        scale: 0.5
      });
    svg.style.border = "1px solid black";
    obj = document.getElementById("SVGArea");
    obj.appendChild(svg);
    if (obj.children.length > 0) {
      obj.replaceChild(svg, obj.children[0]);
    }
  }

</script>
<style>
.custome_bg {
	background:#1aae88;
}
</style>
</head>
<body onLoad="init()" class="">
<section class="vbox">
  <header class="bg-white header header-md navbar navbar-fixed-top-xs box-shadow custome_bg">
    <div class="navbar-header aside-md dk"> <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen" data-target="#nav"> <i class="fa fa-bars"></i> </a> <a href="index.html" class="navbar-brand"> <img src="images/logo.png" class="m-r-sm" alt="scale"> <span class="hidden-nav-xs">S.F</span> </a> <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".user"> <i class="fa fa-cog"></i> </a> </div>
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
            <div class="list-group list-group-alt"> <a href="#" class="media list-group-item"> <span class="pull-left thumb-sm"> <img src="images/a0.png" alt="..." class="img-circle"> </span> <span class="media-body block m-b-none"> Use awesome animate.css<br>
              <small class="text-muted">10 minutes ago</small> </span> </a> <a href="#" class="media list-group-item"> <span class="media-body block m-b-none"> 1.0 initial released<br>
              <small class="text-muted">1 hour ago</small> </span> </a> </div>
            <div class="panel-footer text-sm"> <a href="#" class="pull-right"><i class="fa fa-cog"></i></a> <a href="#notes" data-toggle="class:show animated fadeInRight">See all the notifications</a> </div>
          </section>
        </section>
      </li>
      <li class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span class="thumb-sm avatar pull-left"> <img src="images/a0.png" alt="..."> </span> Karuna <b class="caret"></b> </a>
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
                <div class="dropdown"> <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <span class="thumb avatar pull-left m-r"> <img src="images/a0.png" class="dker" alt="..."> <i class="on md b-black"></i> </span> <span class="hidden-nav-xs clear"> <span class="block m-t-xs"> <strong class="font-bold text-lt">Karuna</strong> <b class="caret"></b> </span> <span class="text-muted text-xs block">Programer</span> </span> </a>
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
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <b class="badge bg-danger pull-right">4</b> <i class="i i-stack icon"> </i> <span class="font-bold">Layouts</span> </a>
                    <ul class="nav dk">
                      <li > <a href="layout-color.html" class="auto"> <i class="i i-dot"></i> <span>Color option</span> </a> </li>
                      <li > <a href="layout-hbox.html" class="auto"> <i class="i i-dot"></i> <span>Hbox layout</span> </a> </li>
                      <li > <a href="layout-boxed.html" class="auto"> <i class="i i-dot"></i> <span>Boxed layout</span> </a> </li>
                      <li > <a href="layout-fluid.html" class="auto"> <i class="i i-dot"></i> <span>Fluid layout</span> </a> </li>
                    </ul>
                  </li>
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-lab icon"> </i> <span class="font-bold">UI kit</span> </a>
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
                      <li  class="active"> <a href="profile.html" class="auto"> <i class="i i-dot"></i> <span>Profile</span> </a> </li>
                      <li > <a href="invoice.html" class="auto"> <i class="i i-dot"></i> <span>Invoice</span> </a> </li>
                      <li > <a href="intro.html" class="auto"> <i class="i i-dot"></i> <span>Intro</span> </a> </li>
                      <li > <a href="master.html" class="auto"> <i class="i i-dot"></i> <span>Master</span> </a> </li>
                      <li > <a href="gmap.html" class="auto"> <i class="i i-dot"></i> <span>Google Map</span> </a> </li>
                      <li > <a href="jvectormap.html" class="auto"> <i class="i i-dot"></i> <span>Vector Map</span> </a> </li>
                      <li > <a href="signin.html" class="auto"> <i class="i i-dot"></i> <span>Signin</span> </a> </li>
                      <li > <a href="signup.html" class="auto"> <i class="i i-dot"></i> <span>Signup</span> </a> </li>
                      <li > <a href="404.html" class="auto"> <i class="i i-dot"></i> <span>404</span> </a> </li>
                    </ul>
                  </li>
                  <li > <a href="#" class="auto"> <span class="pull-right text-muted"> <i class="i i-circle-sm-o text"></i> <i class="i i-circle-sm text-active"></i> </span> <i class="i i-grid2 icon"> </i> <span class="font-bold">Apps</span> </a>
                    <ul class="nav dk">
                      <li > <a href="mail.html" class="auto"> <b class="badge bg-success lt pull-right">2</b> <i class="i i-dot"></i> <span>Mailbox</span> </a> </li>
                      <li > <a href="fullcalendar.html" class="auto"> <i class="i i-dot"></i> <span>Calendar</span> </a> </li>
                      <li > <a href="project.html" class="auto"> <i class="i i-dot"></i> <span>Project</span> </a> </li>
                      <li > <a href="media.html" class="auto"> <i class="i i-dot"></i> <span>Media</span> </a> </li>
                    </ul>
                  </li>
                </ul>
                <div class="line dk hidden-nav-xs"></div>
                <div class="text-muted text-xs hidden-nav-xs padder m-t-sm m-b-sm">Lables</div>
                <ul class="nav">
                  <li> <a href="mail.html#work"> <i class="i i-circle-sm text-info-dk"></i> <span>Work space</span> </a> </li>
                  <li> <a href="mail.html#social"> <i class="i i-circle-sm text-success-dk"></i> <span>Connection</span> </a> </li>
                  <li> <a href="mail.html#projects"> <i class="i i-circle-sm text-danger-dk"></i> <span>Projects</span> </a> </li>
                </ul>
                <div class="text-muted text-xs hidden-nav-xs padder m-t-sm m-b-sm">Circles</div>
                <ul class="nav">
                  <li> <a href="#"> <i class="i i-circle-sm-o text-success-lt"></i> <span>College</span> </a> </li>
                  <li> <a href="#"> <i class="i i-circle-sm-o text-warning"></i> <span>Social</span> </a> </li>
                </ul>
              </nav>
              <!-- / nav -->
            </div>
          </section>
          <footer class="footer hidden-xs no-padder text-center-nav-xs"> <a href="modal.lockme.html" data-toggle="ajaxModal" class="btn btn-icon icon-muted btn-inactive pull-right m-l-xs m-r-xs hidden-nav-xs"> <i class="i i-logout"></i> </a> <a href="#nav" data-toggle="class:nav-xs" class="btn btn-icon icon-muted btn-inactive m-l-xs m-r-xs"> <i class="i i-circleleft text"></i> <i class="i i-circleright text-active"></i> </a> </footer>
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
                                    <li class=""><a data-toggle="tab" href="#step3">Step 3</a></li>
                                    <li class=""><a data-toggle="tab" href="#step2">Step 4</a></li>
                                    <li class=""><a data-toggle="tab" href="#step3">Step 5</a></li>
                                    <li class=""><a data-toggle="tab" href="#step2">Step 6</a></li>
                                  </ul>
                                </div>
                                <div class="panel-body">
                                <div class="line line-lg"></div>
                                <h4>Analysis</h4>
                                <div class="progress progress-xs m-t-md">
                                  <div class="progress-bar bg-success" style="width: 100%;"></div>
                                </div>
                                <div class="tab-content">
                                <div id="step6" class="tab-pane active">

                              </form>
                            </div>

                          </div>
                          </form>
                        </div>
                        <div> <span style="display: inline-block; vertical-align: top; padding: 5px; width:130px">
                          <div id="myPalette" style="border: solid 1px gray; height: 720px"></div>
                          </span> <span style="display: inline-block; vertical-align: top; padding: 5px; width:79%">
                          <div id="myDiagram" style="border: solid 1px gray; height: 720px"></div>
                          </span> </div>
                        <div id="infoDraggable" style="display: inline-block; vertical-align: top; padding: 5px;">
                          <div id="myInfo">Selecting nodes in the main Diagram will display information here</div>
                        </div>
                        <button id="SaveButton" onClick="save()">Save</button>
                        <button onClick="load()">Load</button>
                        <textarea id="mySavedModel">{ "class": "go.GraphLinksModel",
  "linkFromPortIdProperty": "fromPort",
  "linkToPortIdProperty": "toPort",
  "nodeDataArray": [
{"category":"Comment", "loc":"360 -10", "text":"Fault Detection", "key":-13},
{"key":-1, "category":"Start", "loc":"175 0", "text":"Start"},
{"key":0, "loc":"175 77", "text":"SECOM_Dataset"},
{"key":1, "loc":"375 100", "text":"Convert into csv"},
{"key":2, "loc":"175 150", "text":"Project Columns"},
{"key":3, "loc":"175 210", "text":"Missing values scrubber"},
{"key":4, "loc":"175 320", "text":"Filter based Feature Selection"},
{"key":5, "loc":"352 300", "text":"Descriptive Statistic"},
{"key":6, "loc":"175 390", "text":"Split"},
{"key":7, "loc":"150 500", "text":"Logistic Regression"},
{"key":8, "loc":"275 570", "text":"KNN"},
{"key":-2, "category":"End", "loc":"175 640", "text":"End!"}
 ],
  "linkDataArray": [
{"from":0, "to":2, "fromPort":"B", "toPort":"T"},
{"from":2, "to":3, "fromPort":"B", "toPort":"T"},
{"from":3, "to":4, "fromPort":"B", "toPort":"T"},
{"from":4, "to":6, "fromPort":"B", "toPort":"T"},
{"from":6, "to":7, "fromPort":"B", "toPort":"T"},
{"from":6, "to":8, "fromPort":"B", "toPort":"T"},
{"from":-1, "to":0, "fromPort":"B", "toPort":"T"},
{"from":0, "to":1, "fromPort":"B", "toPort":"T"},
{"from":3, "to":5, "fromPort":"B", "toPort":"T"}
 ]}
  </textarea>
                        <!--
<nav class="navbar navbar-inverse navbar-bottom" style="padding:0 0 120px 0">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <h5 id='footer-header'> SITEMAP </h3>
                    <div class="col-sm-4" style="padding: 0 0 0 0px">
                        <p>News</p>
                        <p>contact</p>
                    </div>
                    <div class="col-sm-4" style="padding: 0 0 0 0px">
                        <p>FAQ</p>
                        <p>Privacy Policy</p>
                    </div>
                </div>
                <div class="col-sm-4">
                    <h5 id='footer-header'> xxxx </h3>
                    <p>yyyyyyyyyyyyy</p>
                </div>
                <div class="col-sm-4">
                    <h5 id='footer-header'> xxxxx </h3>
                    <p>uuuuuuuuuuuuuuu</p>
                </div>
            </div>
        </div>
    </nav> -->
                      </div>
                    </div>
                    </div>
                    </section>
                    </div>
                  </section>
                </section>
              </aside>
              <aside class="col-lg-4 b-l no-padder">
              <section class="vbox">
              <section class="scrollable">
              <div class="wrapper">
                <section class="panel panel-default">
                  <footer class="panel-footer bg-light lter">
                    <ul class="nav nav-pills nav-sm">
                      <li><a href="#"><i class="larcon i i-plus2"></i><br />
                        Add</a></li>
                      <li><a href="#"><i class="larcon fa fa-play"></i><br />
                        Run</a></li>
                      <li><a href="#"><i class="larcon fa fa-save"></i><br />
                        Save</a></li>
                      <li><a href="#"><i class="larcon fa fa-bitbucket"></i><br />
                        Del</a></li>
                      <li><a href="#"><i class="larcon i i-history"></i><br />
                        History</a></li>
                    </ul>
                  </footer>
                  <header class="panel-heading"> <span class="lg font-bold">Properties</span> </header>
                  <div class="panel-body">
                    <label class="col-sm-12 control-label font-bold">Filter Based Feature Selection</label>
                    <label class="col-sm-12 control-label">Feature scoring method</label>
                    <select name="account" class="form-control">
                      <option>option 1</option>
                      <option>option 2</option>
                      <option>option 3</option>
                      <option>option 4</option>
                    </select>
                    <div class="checkbox i-checks">
                      <label>
                      <input type="checkbox" value="">
                      <i></i> Option one </label>
                    </div>
                    <section class="panel panel-default">
                      <header class="panel-heading"> <span class="">Target Column</span> </header>
                      <div class="panel-body"> Selected Columns
                        columns body
                        yield_pass_fail </div>
                    </section>
                    <label class="col-sm-12 label-info">Launch Column Selector</label>
                    <div class="form-group">
                      <label class="col-sm-12 control-label">Number of Desired features</label>
                      <div class="col-sm-12">
                        <input type="text" class="form-control">
                      </div>
                    </div>
                  </div>
                </section>
                </ul>
                </section>
                <div class="panel-body"> </div>
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
