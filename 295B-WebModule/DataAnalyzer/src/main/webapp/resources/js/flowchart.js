

init  = function() {
    if (window.goSamples) goSamples();  // init for these samples -- you don't need to call this
    var dollor = go.GraphObject.make;  // for conciseness in defining templates

    myDiagram =
      dollor(go.Diagram, "myDiagram",  // must name or refer to the DIV HTML element
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
          mouseLeave: function (e, obj) { showPorts(obj.part, false); },
          doubleClick: function(e, obj) { addParameters(obj.part.data.key) } 
        }
      ];
    }

    function addParameters(key){
        console.log("key"+key);
        
        var graphkeys = [{"key":-1,"text":"Start", "action":""},{"key":-2,"text":"End!", "action":""}
        ,{"key":-3,"text":"Random Forest", "action":""},{"key":-4,"text":"PCA", "action":""}
        ,{"key":-5,"text":"Logistic Regression", "action":""},{"key":-6,"text":"Linear Regression", "action":""}
        ,{"key":-7,"text":"Comment", "action":""},{"key":-8,"text":"Dataset", "action":"fileUploader"}
        ,{"key":-9,"text":"Feature Selection", "action":"fSelector"},{"key":-10,"text":"Parameter Setting", "action":"paramSetter"}];

        var elem = Math.abs(key)-1;
        
        if(graphkeys[elem].action != ''){
          console.log(graphkeys[elem].text);
          $('#'+graphkeys[elem].action).modal('show');
        }else{
          console.log("no action for "+graphkeys[elem].text);
        }
    }
    
    // Define a function for creating a "port" that is normally transparent.
    // The "name" is used as the GraphObject.portId, the "spot" is used to control how links connect
    // and where the port is positioned on the node, and the boolean "output" and "input" arguments
    // control whether the user can draw links from or to the port.
    function makePort(name, spot, output, input) {
      // the port is basically just a small circle that has a white stroke when it is made visible
        return dollor(go.Shape, "Circle",
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
    
    function showMessage(s) {
      console.log(s);
      $("#mySavedModel").show();
    }

    myDiagram.nodeTemplateMap.add("",  // the default category
      dollor(go.Node, "Spot", nodeStyle(),
        // the main object is a Panel that surrounds a TextBlock with a rectangular Shape
        dollor(go.Panel, "Auto",
          dollor(go.Shape, "Rectangle",
            { fill: "#333333", stroke: null },
            new go.Binding("figure", "figure")),
          dollor(go.TextBlock,
            {
              font: "bold 11pt Helvetica, Arial, sans-serif",
              stroke: lightText,
              margin: 8,
              maxSize: new go.Size(160, NaN),
              wrap: go.TextBlock.WrapFit,
              editable: false
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
      dollor(go.Node, "Spot", nodeStyle(),
        dollor(go.Panel, "Auto",
          dollor(go.Shape, "Circle",
            { minSize: new go.Size(40, 40), fill: "#79C900", stroke: null }),
          dollor(go.TextBlock, "Start",
            { font: "bold 11pt Helvetica, Arial, sans-serif", stroke: lightText },
            new go.Binding("text"))
        ),
        // three named ports, one on each side except the top, all output only:
        makePort("L", go.Spot.Left, true, false),
        makePort("R", go.Spot.Right, true, false),
        makePort("B", go.Spot.Bottom, true, false)
      ));

    myDiagram.nodeTemplateMap.add("End",
      dollor(go.Node, "Spot", nodeStyle(),
        dollor(go.Panel, "Auto",
          dollor(go.Shape, "Circle",
            { minSize: new go.Size(40, 40), fill: "#DC3C00", stroke: null }),
          dollor(go.TextBlock, "End",
            { font: "bold 11pt Helvetica, Arial, sans-serif", stroke: lightText },
            new go.Binding("text"))
        ),
        // three named ports, one on each side except the bottom, all input only:
        makePort("T", go.Spot.Top, false, true),
        makePort("L", go.Spot.Left, false, true),
        makePort("R", go.Spot.Right, false, true)
      ));

    myDiagram.nodeTemplateMap.add("Comment",
      dollor(go.Node, "Auto", nodeStyle(),
        dollor(go.Shape, "File",
          { fill: "#c2c2a3", stroke: null }),
        dollor(go.TextBlock,
          {
            margin: 5,
            maxSize: new go.Size(200, NaN),
            wrap: go.TextBlock.WrapFit,
            textAlign: "center",
            editable: true,
            font: "bold 12pt Helvetica, Arial, sans-serif",
            stroke: '#000000'
          },
          new go.Binding("text").makeTwoWay())
        // no ports, because no links are allowed to connect with a comment
      ));

    // replace the default Link template in the linkTemplateMap
    myDiagram.linkTemplate =
      dollor(go.Link,  // the whole link panel
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
        dollor(go.Shape,  // the highlight shape, normally transparent
          { isPanelMain: true, strokeWidth: 8, stroke: "transparent", name: "HIGHLIGHT" }),
        dollor(go.Shape,  // the link path shape
          { isPanelMain: true, stroke: "gray", strokeWidth: 2 }),
        dollor(go.Shape,  // the arrowhead
          { toArrow: "standard", stroke: null, fill: "gray"}),
        dollor(go.Panel, "Auto",  // the link label, normally not visible
          { visible: false, name: "LABEL", segmentIndex: 2, segmentFraction: 0.5},
          new go.Binding("visible", "visible").makeTwoWay(),
          dollor(go.Shape, "RoundedRectangle",  // the label shape
            { fill: "#F8F8F8", stroke: null }),
          dollor(go.TextBlock, "Yes",  // the label
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

    nodeTemplate = 
    dollor(go.Node, "Vertical",
      { locationObjectName: "TB", locationSpot: go.Spot.Center },
      dollor(go.Shape,
        { width: 20, height: 20, fill: "white" },
        new go.Binding("fill", "color")),
      dollor(go.TextBlock, { name: "TB" },
        new go.Binding("text", "color"))
    );
    // initialize the Palette that is on the left side of the page
    addPallete = function(){
    myPalette =
      dollor(go.Palette, "myPalette",  // must name or refer to the DIV HTML element
        {
          "animationManager.duration": 800, // slightly longer than default (600ms) animation
          nodeTemplateMap: myDiagram.nodeTemplateMap,  // share the templates used by myDiagram
          model: new go.GraphLinksModel([  // specify the contents of the Palette
            { category: "Comment", text: "Comment" },
            { text: "Random Forest" },
            { text: "PCA" },
            { text: "Logistic Regression" },
            { text: "Linear Regression" }
          ])
        });
    }
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
    var processjson = myDiagram.model.toJson();
    //console.log(processjson);
    $.ajax({
      url: "http://localhost:8080/dataanalyzer/processflow",
      type: 'POST',
      dataType: 'text',
      processData: false,
      contentType: false,
      data: processjson,
      success: function (response) {
        console.log(response);
      },
      error: function (jqXHR) {
        console.log("err : ");
        console.log(jqXHR);
      }
     });
    myDiagram.isModified = false;
  }

  function load() {
    var reload = '{ "class": "go.GraphLinksModel",'
                  +'"linkFromPortIdProperty": "fromPort",'
                  +'"linkToPortIdProperty": "toPort",'
                  +'"nodeDataArray": ['
                  +'{"key":-1, "category":"Start", "loc":"175 -800", "text":"Start"},'
                  +'{"key":-2, "category":"End", "loc":"175 -500", "text":"End!"}],'
                  +'"linkDataArray": []}'; 
    var jsonBom = $('#jsonBom').val();
    if(jsonBom != ""){
      myDiagram.model = go.Model.fromJson(jsonBom);
    }else{
      console.log("load default process flow");
      myDiagram.model = go.Model.fromJson(reload);
    }
  }

  function reset() {
    var reload = '{ "class": "go.GraphLinksModel",'
                  +'"linkFromPortIdProperty": "fromPort",'
                  +'"linkToPortIdProperty": "toPort",'
                  +'"nodeDataArray": ['
                  +'{"key":-1, "category":"Start", "loc":"175 -800", "text":"Start"},'
                  +'{"key":-2, "category":"End", "loc":"175 -500", "text":"End!"}],'
                  +'"linkDataArray": []}'; 
    myDiagram.model = go.Model.fromJson(reload);
  }

  function setFlow(flow) {
    myDiagram.model = go.Model.fromJson(flow);
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

  $(document).ready(function(){
	  
	  var graphkeys = [{"key":-1,"text":"Start", "loc":"70 -500"},{"key":-2,"text":"End!", "loc":"70 -500"}
	  ,{"key":-3,"text":"Random Forest", "loc":"70 -600"},{"key":-4,"text":"PCA", "loc":"70 -500"}
	  ,{"key":-5,"text":"Logistic Regression", "loc":"70 -500"},{"key":-6,"text":"Linear Regression", "loc":"70 -500"}
	  ,{"key":-7,"text":"Comment", "loc":"70 -500"},{"key":-8,"text":"Dataset", "loc":"70 -500"}
	  ,{"key":-9,"text":"Feature Selection", "loc":"70 -500"},{"key":-10,"text":"Parameter Setting", "loc":"70 -500"}];
	 /*$("#dataset").click(function(){
		 if($('#up').is(":visible")){
			 $('#up').hide();
		 }else{
			 $('#up').show();
		 } 
	 }); */
	 
	 $('#datasetButton').on('click', function () {
		 var form = new FormData(document.getElementById('datasetform'));
		 $.ajax({
		  url: "http://localhost:8080/dataanalyzer/uploaddataset",
		  data: form,
		  dataType: 'text',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function (response) {
		      var json = JSON.parse(response);
		      //console.log(json);
          $("#fsdiv").html("");
          var html = '<table id="fstable" class="table table-striped table-bordered"';
          html += 'cellspacing="0" data-click-to-select="true">';
          html += '<thead><tr><th data-field="cn">Column Name</th><th data-field="state"';
          html += 'data-checkbox="true"></th></tr></thead><tbody>';

		      for (var key in json) {
	    	   if (json.hasOwnProperty(key)) {
	    	     //console.log(key + " -> " + json[key]);
            html += '<tr><td></td><td>'+key+'</td></tr>';    
	    	   }
	    	  }
          html += '</tbody></table>';
          $("#fsdiv").append(html);
          $('#fstable').DataTable();
		      $('#fileUploader').modal('hide');
          var diajson = JSON.parse(myDiagram.model.toJson());
          diajson.nodeDataArray.push(graphkeys[7]);
          setFlow(diajson);
		  },
		  error: function (jqXHR) {
			  console.log(jqXHR);
		  }
		 });
	  });
	 
	 $("#fsButton").click(function(){
     var diajson = JSON.parse(myDiagram.model.toJson());
     diajson.nodeDataArray.push(graphkeys[8]);
     setFlow(diajson);
     $('#fSelector').modal('hide');
	 });
	 
	 $("#psButton").click(function(){
		 var diajson = JSON.parse(myDiagram.model.toJson());
     diajson.nodeDataArray.push(graphkeys[9]);
     setFlow(diajson);
     $('#paramSetter').modal('hide');
	 });

   $("#delete").click(function(){
      $.ajax({
      url: "http://localhost:8080/dataanalyzer/experiment",
      dataType: 'text',
      processData: false,
      contentType: false,
      type: 'DELETE',
      success: function (response) {
        console.log(response);
        location.href = "http://localhost:8080/dataanalyzer/";
      },
      error: function (jqXHR) {
        console.log(jqXHR);
      }
     });
   });

   $("#run").click(function(){
      var idx = document.title.indexOf("*");
      if (idx >= 0){
        console.log("saving the process..");
        save();
        //TODO: run flow / send process flow to backend
        console.log("running process");
      }else{
        //TODO: run flow / send process flow to backend
        console.log("running process");
      } 
      
   });

   function run(){
      var processjson = myDiagram.model.toJson();
      $.ajax({
        url: "http://localhost:8080/dataanalyzer/execute",
        type: 'POST',
        dataType: 'text',
        processData: false,
        contentType: false,
        data: processjson,
        success: function (response) {
          console.log(response);
        },
        error: function (jqXHR) {
          console.log("err : ");
          console.log(jqXHR);
        }
       });
   }

	 var flag = true;
	 $("#algo").click(function(){
		 if(flag){
			 var html = '<div id="myPalette" class="palletey"></div>';
			 $("#palleteDiv").append(html);
			 addPallete();
			 flag = false;
		 }else{
			 $("#palleteDiv").html("");
			 flag = true;
		 }
	 });
  });