$(document).ready(function(){
	$('#chamberUL li > a').click(function(e){
	    //$('#chamber').text(this.innerHTML);
	    console.log(this.innerHTML);
	    
        var data = 'chamber_id='+this.innerHTML;

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
          }
        });
	    
	});
	/*$( "#chamber" ).click(function() {
		console.log($( "#chamber" ).val());
	});*/
      
});