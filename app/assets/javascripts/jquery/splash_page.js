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

	$('#test_link').click(function() {
		alert("testing!");
		$("#bleh").show();
	});

	$("#ok_again").css('color', "Red");


	document.querySelector("#ok").style.color = "Purple";
});
