$(document).ready(function(){
	//$('#chamberUL li > a').click(function(e){
	$('#chamberUL').change(function(){
	//$('#chamber').text(this.innerHTML);
	    console.log($("#chamberUL").val());
	    
        var data = 'chamber_id='+$("#chamberUL").val();

        $.ajax({
          type: "GET",
          url: "/dataanalyzer/lam/date",
          contentType: "application/json; charset=UTF-8",
          dataType: 'json',
          data: data,
          crossDomain : true,
          error: function( err ) {
             console.log(err);
          },success: function(d){
        	  console.log(d);
              var html = '';
              $("#dateUL").html("");
              html += '<option val="#" selected>Select Date</option>';
              for(var z=0;z<d.length;z++){
               	//html += '<li><a href="#">'+d[z]+'</a></li>'
            	  html += '<option val="'+d[z]+'">'+d[z]+'</option>';
              }
              $("#dateUL").append(html);
          }
        });
	});
	
	$('#dateUL').change(function(){
		console.log($("#chamberUL").val()+" <chamber date>"+$("#dateUL").val());
		var data = 'chamber_id='+$("#chamberUL").val()+'&date_id='+$("#dateUL").val();

        $.ajax({
          type: "GET",
          url: "/dataanalyzer/lam/date/file",
          contentType: "application/json; charset=UTF-8",
          dataType: 'json',
          data: data,
          crossDomain : true,
          error: function( err ) {
        	  console.log("THIS>>> " + err);
        	  var html = '';
              $("#fileUL").html("");
              for(var z=0;z<err.length;z++){
               	//html += '<li><a href="#">'+d[z]+'</a></li>'
            	  html += '<option val="'+err[z]+'">'+err[z]+'</option>';
              }
              $("#fileUL").append(html);
          },success: function(d){
        	  console.log(d);
              var html = '';
              $("#fileUL").html("");
              html += '<option val="#" selected>Select File</option>';
              for(var z=0;z<d.length;z++){
               	//html += '<li><a href="#">'+d[z]+'</a></li>'
            	  html += '<option val="'+d[z]+'">'+d[z]+'</option>';
              }
              $("#fileUL").append(html);
          }
        });
    });
	
	
	$('#fileUL').change(function(){
		//$('#chamber').text(this.innerHTML);
		console.log($("#chamberUL").val()+" <chamber date>"+$("#dateUL").val()+" <date filename>"+$("#fileUL").val());
		var data = 'chamber_id='+$("#chamberUL").val()+'&date_id='+$("#dateUL").val()+'&file_id='+$("#fileUL").val();
		console.log("THIS DATA:>>> "+data);
	        $.ajax({
	          type: "GET",
	          url: "/dataanalyzer/lam/date/file/attribute",
	          contentType: "application/json; charset=UTF-8",
	          dataType: 'json',
	          data: data,
	          crossDomain : true,
	          error: function( err ) {
	             console.log(err);
	          },success: function(d){
	        	  console.log(d);
	              var html = '';
	             
	              $("#attributeUL").html("");
	              html += '<option val="#" selected>Select Attribute</option>';
	              for(var z=0;z<d.length;z++){
	               	//html += '<li><a href="#">'+d[z]+'</a></li>'
	            	  html += '<option val="'+d[z]+'">'+d[z]+'</option>';
	              }
	              $("#attributeUL").append(html);
	          }
	        });
		});
	
	
	
	$('#attributeUL').change(function(){
		//$('#chamber').text(this.innerHTML);
		console.log($("#chamberUL").val()+" <chamber date>"+$("#dateUL").val()+" <date filename>"+$("#fileUL").val());
		var data = 'chamber_id='+$("#chamberUL").val()+'&date_id='+$("#dateUL").val()+'&file_id='+$("#fileUL").val()+'&attribute_id='+$("#attributeUL").val();
		console.log("THIS DATA:>>> "+data);
	        $.ajax({
	          type: "GET",
	          url: "/dataanalyzer/lam/graphs",
	          contentType: "application/json; charset=UTF-8",
	          dataType: 'json',
	          data: data,
	          crossDomain : true,
	          error: function( err ) {
	             console.log(err);
	          },success: function(d){
	        	  console.log("----");
	        	  callChart(d);
//	              var html = '';
//	              $("#attributeUL").html("");
//	              for(var z=0;z<d.length;z++){
//	               	//html += '<li><a href="#">'+d[z]+'</a></li>'
//	            	  html += '<option val="'+d[z]+'">'+d[z]+'</option>';
//	              }
//	              $("#attributeUL").append(html);
	          }
	        });
		});
	
	

function callChart(data) {
		console.log("received data to build graph: "+JSON.stringify(data));
		
		var attribute="";
		var unit="";
		var jsonData="";
		for(var key in data){
			if(key=="Attribute"){ attribute=data[key];}
			if(key=="Unit"){unit=data[key];}
			if(key=="Values"){jsonData=data[key];}
		}
		console.log("Values::: "+jsonData);
		
		
		var chart1 = AmCharts.makeChart("chartdiv", {
		    "type": "serial",
		    "theme": "light",
		    "marginRight": 70,
		    "autoMarginOffset": 20,
		    "titles": [
		       		{
		       			"text": attribute,
		       			"size": 18
		       		}
		       	],
		    "dataProvider": jsonData,
		    "balloon": {
		        "cornerRadius": 6
		    },
		    "valueAxes": [{
		    	"id": "v1",
		        "axisAlpha": 0,
		        "title": unit
		    }],
		    "graphs": [{
		        "balloonText": "[[category]]<br><b><span style='font-size:14px;'>[[value]] "+unit+"</span></b>",
		        "bullet": "round",
		        "title":"timmeee",
		        "bulletSize": 6,
		        "connect": false,
		        "lineColor": "#b6d278",
		        "lineThickness": 2,
		        "negativeLineColor": "#487dac",
		        "valueField": "Value",
		        "animationPlayed": true,
		        "title":"[[Time]]",
		        "descriptionField": "name",
		        "valueAxis": "v1"
		        
		    }],
		    "chartCursor": {
		        "categoryBalloonDateFormat": "YYYY",
		        "cursorAlpha": 0.1,
		        "cursorColor": "#000000",
		        "fullWidth": true,
		        "graphBulletSize": 2
		    },
		    "chartScrollbar": {},
		    "dataDateFormat": "YYYY",
		    "categoryField": "Time",
		    "categoryAxis": {
		        "minorGridEnabled": true,
		        "labelRotation": 60
		    },
		    "export": {
		        "enabled": true
		    }
		});

		
}
	

	
	
	
	
	
	
});