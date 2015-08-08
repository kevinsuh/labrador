$(document).on('ready page:load', function() {

	$('#waitlist_email').focus(function() {
		$('#submit_waitlist').addClass('active')
	});

	$('#waitlist_email').blur(function() {
		$('#submit_waitlist').removeClass('active')
	});

});