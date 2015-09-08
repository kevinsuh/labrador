$(document).on('ready page:load', function() {

	// submit payment options
	var show_error, stripeResponseHandler;
	// use subimt event of the form to interact with stripe
	$("#newCard").submit(function(e) {
		e.preventDefault();
		var $form;
		$form = $(this);
		$form.find("input[type=submit]").prop("disabled", true);
		Stripe.card.createToken($form, stripeResponseHandler);
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
			$("[data-stripe=number]").remove();
      $("[data-stripe=cvv]").remove();
      $("[data-stripe=exp_year]").remove();
      $("[data-stripe=exp_month]").remove();
      $form.get(0).submit();
		}
		return false;
	}


	var show_error = function(message) {
		$("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
    $('.alert').delay(5000).fadeOut(3000);
    return false;
	}

});