$(document).on('ready page:load', function() {

	// waitlist input functions
	$('#new_address').click(function(e) {
		e.preventDefault();
		$('div.address').fadeToggle();
	});

});