$(document).ready(function(){
	
	$( "#chamber" ).click(function() {
		console.log($( "#chamber" ).val());
	});
      $( "#savename" ).click(function() {
        var name = $("#name").val();
          var nameObj = {
          name : name
        };

        $.ajax({
          type: "POST",
          url: "/company/"+$("#companyId").val()+"/name",
          contentType: "application/json; charset=UTF-8",
          dataType: 'json',
          data: JSON.stringify(nameObj),
          crossDomain : true,
          success: function( d ) {
             console.log(d);
          }
        });
        $("#savename").hide();
        $("#editname").show();
        $("#name").prop('disabled', true);
      });
});