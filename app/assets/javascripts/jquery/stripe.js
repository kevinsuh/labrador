$(document).on('ready page:load', function() {

	// submit payment options
	var show_error, stripeResponseHandler;
	// use subimt event of the form to interact with stripe
	$("#newCard").submit(function(e) {
		e.preventDefault();
		var $form;
		$form = $(this);
		$form.find("input[type=submit]").prop("disabled", true);
		Stripe.card.createToken({
			number: $('.cc_number').val(),
			cvc: $('.cc_cvc').val(),
			exp_month: $('.cc_exp_month').val(),
			exp_year: $('.cc_exp_year').val(),
			name: $('.cc_name').val(),
			address_line1: $('.cc_street1').val(),
			address_city: $('.cc_city').val(),
			address_state: $('.cc_state').val(),
			address_zip: $('.cc_zipcode').val()}, stripeResponseHandler);
		return false;
	})

	var stripeResponseHandler = function (status, response) {
		var $form, token;
		$form = $("#newCard");
		if (response.error) {
			show_error(response.error.message);
			$form.find("input[type=submit]").prop("disabled", false);
		} else {
			// successful charge on stripe
			// this means we received token in place of the card information, which we then replace all cc info with the token to satisfy PCI compliance
			token = response.id;
			$form.append($("<input type=\"hidden\" name=\"registration[card_token]\" />").val(token))
			$(".cc_number").remove();
      $(".cc_cvc").remove();
      $(".cc_exp_month").remove();
      $(".cc_exp_year").remove();
      $form.get(0).submit();
		}
		return false;
	}


	var show_error = function(message) {
		$("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
    $('.alert').delay(5000).fadeOut(3000);
    return false;
	}

	// make inputs properly format to cc
	$('input.card-number-input').payment('formatCardNumber');
	$('input.card-verification').payment('formatCardCVC');


});