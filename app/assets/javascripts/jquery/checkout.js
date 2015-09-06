$(document).on('ready page:load', function() {

	// waitlist input functions
	$('#new_address').click(function(e) {
		e.preventDefault();
		$('.address_form_div').fadeToggle();
	});

});