$(document).ready(function(){
	$("#myExp").click(function(){
		$.ajax({
          type: "GET",
          url: "./experimentlist",
          contentType: "application/json; charset=UTF-8",
          dataType: 'json',
          crossDomain : true,
          error: function( err ) {
              console.log("err "+err);
          },success: function(d){
        	  if(d.length>0){
	        	  $("#experiments").html("");
	        	  var  html = '<table id="myTable" class="table table-hover"><thead><tr>';
        		  html += '<th></th><th>Experiment Name</th><th>Last Modified</th><th></th></tr></thead><tbody>';
	        	  
	        	  for(var i=0;i<d.length;i++){
	        		  html += '<tr id="'+d[i].uuid.$uuid+'"><td><a id="delete'+i+'" href="#"><img alt="delete" src="./resources/images/delete.png" width="30" height="30"/></a></td>';
	        		  html += '<td>'+d[i].experiment_name+'</td><td>'+d[i].timestamp+'</td>';
	        		  
	        		  html += '<td><form method="POST" action="./experiment/id"> <input id="experiment_id" type="input" name="experiment_id" value="'+d[i].uuid.$uuid+'" hidden/>';
	        		  html += '<button id="launch" class="btn btn-success" type="submit">Launch</button></form></td></tr>';	  
	        		  //html += '<td><button id="delete'+i+'" class="btn btn-success"> Delete </button></td></tr>';
	        	  }
	        	  
	        	  html += '</tbody></table>';
	        	  $("#experiments").append(html);
	        	  for(var i=0;i<d.length;i++){
	        		  $("#delete"+i).click(function(){
		        			var experiment_id = $(this).parent().parent().attr('id');
		        	        $.ajax({
		        	            type: "DELETE",
		        	            url: "./experiment/id/"+experiment_id,
		        	            contentType: "application/json; charset=UTF-8",
		        	            dataType: 'text',
		        	            crossDomain : true,
		        	            error: function( err ) {
		        	            	console.log("err : ");
		        	                console.log(err);
		        	            },success: function(d){
		        	            	$("#"+experiment_id).remove();
		        	            }
		        	        });    
		        	  });
	        	  }
        	  }else{
        		  $("#experiments").html("");
        		  var html = "<div>No experiemnts</div>";
        		  $("#experiments").append(html);
        	  }
          }
        });
	});
	
	$("#visual").click(function(){
      location.href="http://localhost:8080/dataanalyzer/lam";
    });
});