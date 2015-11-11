$(document).on('ready page:load', function() {

	// waitlist input functions
	$('#waitlist_email').focus(function() {
		$(this).addClass('active')
		$('#submit_waitlist').addClass('active')
	});

	$('#waitlist_email').blur(function() {
		if (!$(this).val()) {
			$(this).removeClass('active')
			$('#submit_waitlist').removeClass('active')
		}
	});

	 if ('ontouchstart' in window) {
	    /* cache dom references */ 
	    var $body = $('body'); 

	    /* bind events */
	    $(document)
	    .on('focus', 'input', function() {
	        $body.addClass('fixfixed');
	    })
	    .on('blur', 'input', function() {
	        $body.removeClass('fixfixed');
	    });
	}

});
