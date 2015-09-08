$(document).on('ready page:load', function() {

	/**
	 * 			ADDRESSES
	 */
	
	// show new address form
	$('#new_address').click(function(e) {
		
		e.preventDefault();
		var new_address_form = $('#new_address_form');
		new_address_form.fadeToggle(200);

	});

	// update default address whenever new one gets checked
	$('input[type=radio].select_address').change(function() {
		$('input[type=radio].select_address').each(function() {

			var addressDiv = $(this).parent().parent();
			if ($(this).is(':checked')) {
				addressDiv.addClass('selected');
			} else {
				addressDiv.removeClass('selected');
			}

		})
	})

	// show specific address form on edit button
	$('button.edit_address').click(function(e) {
		
		var address      = $(this).parent().parent().parent();
		var address_item = address.find('.address_item');
		var address_form = address.find(".address_form_div");

		address_item.fadeToggle(200, function() {
			address_form.fadeToggle();
		});

	});

	// cancel to show back the prev form 
	$('button.cancel_address_update').click(function(e) {

		var address      = $(this).parent().parent().parent().parent().parent();
		var address_item = address.find('.address_item');
		var address_form = address.find('.address_form_div');

		address_form.fadeToggle(200, function() {
			address_item.fadeToggle(200);
		});

	});

	/**
	 * 			CARDS
	 */
	
	// add new card or not
	$('#add_new_card').click(function(e) {
		e.preventDefault();
		$('#new_card_form').fadeToggle();
	});

	// show specific card form on edit button
	$('button.edit_card').click(function(e) {
		
		var card      = $(this).parent().parent().parent();
		var card_item = card.find('.card_item');
		var card_form = card.find('.update_card_form');

		card_item.fadeToggle(200, function() {
			card_form.fadeToggle(200);
		});
	});

	$('button.cancel_billing_card_update').click(function(e) {

		var card      = $(this).parent().parent().parent().parent().parent();
		var card_item = card.find('.card_item');
		var card_form = card.find('.update_card_form');

		card_form.fadeToggle(200, function() {
			card_item.fadeToggle(200);
		})		

	})

	$("#new_card_form input.same_billing_address").click(function() {

		var newCardFormDiv = $(this).parent().parent().parent();
		var default_address = newCardFormDiv.find('.default_address');
		var new_address = newCardFormDiv.find('.new_address');

		if ($(this).prop('checked')) {
			new_address.fadeOut(200, function() {
				default_address.fadeIn(200);
			})
		} else {
			default_address.fadeOut(200, function() {
				new_address.fadeIn(200);
			});
		}
	})

});

/* generic method to post request via javascript */
function post(path, params, method) {
	method = method || "post"; // Set method to post by default if not specified.

	// The rest of this code assumes you are not using a library.
	// It can be made less wordy if you use one.
	var form = document.createElement("form");
	form.setAttribute("method", method);
	form.setAttribute("action", path);

	for(var key in params) {
		if(params.hasOwnProperty(key)) {
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", key);
			hiddenField.setAttribute("value", params[key]);

			form.appendChild(hiddenField);
		 }
	}
	document.body.appendChild(form);
	form.submit();
}