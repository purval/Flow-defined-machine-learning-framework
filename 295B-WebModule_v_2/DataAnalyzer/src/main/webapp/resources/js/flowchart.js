
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
          doubleClick: function(e, obj) { addParameters(obj.part.data.text) } 
        }
      ];
    }

    function addParameters(text){
        console.log("text "+text);
        
        var graphkeys = [{"key":-1,"text":"Comment", "action":""},{"key":-2,"text":"Boosted Decision Tree", "action":""}
        ,{"key":-3,"text":"Decision Tree", "action":""},{"key":-4,"text":"Gradient Boosting", "action":""}
        ,{"key":-5,"text":"Logistic Regression", "action":""},{"key":-6,"text":"Extra Trees Classifier", "action":""}
        ,{"key":-7,"text":"K-best Features", "action":""},{"key":-8,"text":"Recursive Feature Elimination", "action":""}
        ,{"key":-9,"text":"Dataset", "action":"fileUploader"},{"key":-10,"text":"Feature Selection", "action":"fSelector"}
        ,{"key":-11,"text":"Parameter Setting", "action":"paramSetter"}];

        for(var i=0;i<graphkeys.length;i++){
          if(graphkeys[i].text === text){
            try{
              $('#'+graphkeys[i].action).modal('show');
            }catch(err){
              console.log("model not present");
            }
          }
        }

        /*
        var elem = Math.abs(key)-1;
        
        if(graphkeys[elem].action != ''){
          console.log(graphkeys[elem].text);
          $('#'+graphkeys[elem].action).modal('show');
        }else{
          console.log("no action for "+graphkeys[elem].text);
        }*/
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
          { text: "Boosted Decision Tree" },
          { text: "Decision Tree" },
          { text: "Gradient Boosting" },
          { text: "Logistic Regression" },
          { text: "Extra Trees Classifier" },
          { text: "K-best Features" },
          { text: "Recursive Feature Elimination" }
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
    $("#fsdiv").html("");
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

  function polling(){
    $.ajax({
      url: "http://localhost:8080/dataanalyzer/consolelog",
      type: 'GET',
      dataType: 'text',
      processData: false,
      contentType: false,
      success: function (response) {
        try{
          var responseJson = JSON.parse(response);
          if(responseJson.length != 0){
            var html = "";
            for(var i=0;i<responseJson.length;i++){
              html+= '<p class="ptext"> >> '+responseJson[i].timestamp+' : '+responseJson[i].message+'</p>';
            }
            $("#consolelog").append(html);
            $('#consolelog').animate({scrollTop: $('#consolelog').get(0).scrollHeight}, 0);
          }
        }catch(err){
          console.log(err);
          $("#consolelog").append(response);
          $('#consolelog').animate({scrollTop: $('#consolelog').get(0).scrollHeight}, 0);
        }
      },
      error: function (jqXHR) {
        console.log("err : ");
        console.log(jqXHR);
      }
    });
  }

  function pollServerLogs(){
    setInterval(function(){ polling(); }, 5000);
  }

  $(document).ready(function(){
	//pollServerLogs();
	var fsjson;
    var feList = [];
    var autosearch = [];
    var missingval = "zero";
    var metadata = $("#metadata").val();

    if(metadata != ''){
      generate(metadata);
    }

    var graphkeys = [{"key":-1,"text":"Comment", "loc":"70 -500"}
    ,{"key":-2,"text":"Boosted Decision Tree", "loc":"70 -500"}
    ,{"key":-3,"text":"Decision Tree", "loc":"70 -600"}
    ,{"key":-4,"text":"Gradient Boosting", "loc":"70 -600"}
    ,{"key":-5,"text":"Logistic Regression", "loc":"70 -600"}
    ,{"key":-6,"text":"Extra Trees Classifier", "loc":"70 -600"}
    ,{"key":-7,"text":"K-best Features", "loc":"70 -500"}
    ,{"key":-8,"text":"Recursive Feature Elimination", "loc":"70 -500"}
    ,{"key":-100,"text":"Dataset", "loc":"70 -700"}
    ,{"key":-101,"text":"Feature Selection", "loc":"70 -650"}
    ,{"key":-102,"text":"Parameter Setting", "loc":"100 -650"}];

    var graphtext = [""];
    
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
          reset();
          generate(response);
          $('#fileUploader').modal('hide');
          var diajson = JSON.parse(myDiagram.model.toJson());
          diajson.nodeDataArray.push(graphkeys[8]);
          setFlow(diajson);
          save();
      },
      error: function (jqXHR) {
        console.log(jqXHR);
      }
     });
    });

    function generate(response){
      feList=[];
      var replString = response.replace('[','').replace(']','');
      var resSplit = replString.split(",");
      autosearch = [];
      $("#fsdiv").html("");
      var html = ''; var i;
      for(i=0;i<resSplit.length;i++){
        html += '<div class="box" id="box'+i+'"><a class="boxclose" id="'+i+'"></a>'+resSplit[i].trim().replace('\"','').replace('\"','')+'</div>';
        autosearch.push(resSplit[i].trim().replace('\"','').replace('\"',''));
      }
      $("#fsdiv").append(html);
      var j = 0;
      while(j<i){
        $('#'+j).click(function(){
          feList.push(this.id);
          $('#box'+this.id).hide();
        });
        j++;
      }

      $('#featuresearch').autocomplete({
        source: autosearch
      });
    }

   function queryParams() {
        return {
            type: 'owner',
            sort: 'updated',
            direction: 'desc',
            per_page: 100,
            page: 1
        };
    }
    
   function checkDuplicates(nodeDataArray, graphkey){
      var flag = false;
      for(var i=0; i<nodeDataArray.length;i++){
        if(nodeDataArray[i].key == graphkey.key){
          flag = true;
        } 
      }
      return flag;
   } 

   $("#fsButton").click(function(){
     console.log(JSON.stringify(feList));
     $.ajax({
      url: "http://localhost:8080/dataanalyzer/exclude",
      type: 'POST',
      dataType: 'text',
      processData: false,
      contentType: false,
      data: JSON.stringify(feList),
      success: function (response) {
        console.log(response);
        var diajson = JSON.parse(myDiagram.model.toJson());
        if(!checkDuplicates(diajson.nodeDataArray, graphkeys[9])){
          diajson.nodeDataArray.push(graphkeys[9]);
          setFlow(diajson);
          save();
        }
      },
      error: function (jqXHR) {
        console.log("err : ");
        console.log(jqXHR);
      }
     });
     $('#fSelector').modal('hide');
   });
   
   $("#psButton").click(function(){
     var split = $("#split").val();
     if(split == ''){
      split = "70/30";
     }
     var target = $("#featuresearch").val();

     var obj = {
        split : split,
        missingval : missingval,
        target : target
     };

     $.ajax({
      url: "http://localhost:8080/dataanalyzer/parameters",
      type: 'POST',
      dataType: 'text',
      processData: false,
      contentType: false,
      data: JSON.stringify(obj),
      success: function (response) {
        var diajson = JSON.parse(myDiagram.model.toJson());
        if(!checkDuplicates(diajson.nodeDataArray, graphkeys[10])){
          diajson.nodeDataArray.push(graphkeys[10]);
          setFlow(diajson);
          save();
        }
      },
      error: function (jqXHR) {
        console.log("err : ");
        console.log(jqXHR);
      }
     });
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
      var processjson = myDiagram.model.toJson();
      var diajson = JSON.parse(myDiagram.model.toJson());
      var orderedProcess = validateFlow(diajson.linkDataArray, diajson.nodeDataArray);
      if(orderedProcess.length > 0){
        if (idx >= 0){
          console.log("saving the process..");
          save();
          console.log("running process");
          run(orderedProcess);
        }else{
          console.log("running process");
          run(orderedProcess);
        }
      }else{
        alert("Compelete the process flow to execute: Start --> x --> y --> z --> End!");
      }
   });

   function validateConnectedFlow(linkDataArray){
    var counter = 0;
    var index = 0;
    var valid = false;
    for(var i=0;i<linkDataArray.length;i++){
      if(linkDataArray[i].from === -1){
        index = i;
      }
    }
    while(counter < linkDataArray.length){
      if(linkDataArray[index].to == -2){
        valid = true;
        break;
      }
      for(var i=0;i<linkDataArray.length;i++){
        if(linkDataArray[i].from === linkDataArray[index].to){
          index = i;
          break;
        }
      }
      counter++;
    }
    return valid;
   }

   function getText(key, nodeDataArray){
    for(var i=0;i<nodeDataArray.length;i++){
      if(nodeDataArray[i].key === key){
        return nodeDataArray[i].text;
      }
    }
   } 

   function validateFlow(linkDataArray, nodeDataArray){
      console.log("validating process flow");
      var orderedProcess = [];
      if(validateConnectedFlow(linkDataArray)){
        for(var i=0;i<linkDataArray.length;i++){
          if($.inArray(linkDataArray[i].from,orderedProcess) === -1){
            orderedProcess.push(getText(linkDataArray[i].from, nodeDataArray));
            if(linkDataArray[i].to === -2){
              orderedProcess.push(getText(linkDataArray[i].to, nodeDataArray));
              break;  
            }
          }
        }
        console.log(orderedProcess);  
        return orderedProcess;
      }else{
        return orderedProcess;
      }
   } 

   function run(processjson){
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

   $("#zero").click(function(){
    missingval = this.id;
   });
   $("#mean").click(function(){
    missingval = this.id;
   });
   $("#median").click(function(){
    missingval = this.id;
   });

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

   $("#visual").click(function(){
    location.href="http://localhost:8080/dataanalyzer/lam";
   });

   $("#clear").click(function(){
    $("#consolelog").html("");
   });
});
