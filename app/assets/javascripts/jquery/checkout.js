$(document).on('ready page:load', function() {

	/**
	 * 			ADDRESSES
	 */
	
	// show new address form
	$('#new_address').click(function(e) {
		e.preventDefault();
		var address_forms = $('.address_form_div');
		address_forms.each(function() {
			if ($(this).data('address-id') == "new") {
				$(this).fadeToggle();		
			}
		});
	});

	// update default address whenever new one gets checked
	$('input[type=radio].select_address').change(function() {
		$('input[type=radio].select_address').each(function() {
			var addressDiv = $(this).parent().parent();
			if ($(this).is(':checked')) {
				addressDiv.addClass('default');
			} else {
				addressDiv.removeClass('default');
			}
		})
	})

	// show specific address form on edit button
	$('button.edit_address').click(function(e) {
		e.preventDefault();
		var address_info = $(this).parent().parent();
		var address_id = $(this).data('address-id');
		var address_forms = $('.address_form_div');
		address_forms.each(function() {
			if ($(this).data('address-id') == address_id) {
				address_form = $(this);
				address_info.fadeToggle(200, function() {
					address_form.fadeToggle();	
				});
			};
		});
	});

	// cancel to show back the prev form 
	$('button.cancel_update').click(function(e) {
		var address_parent = $(this).parent().parent().parent().parent().parent();
		var address_info = address_parent.find('.address_item');
		var address_form = address_parent.find('.address_form_div');
		address_form.fadeToggle(200, function() {
			address_info.fadeToggle();
		})

	});

	/**
	 * 			CARDS
	 */
	
	// add new card or not
	$('#add_new_card').click(function(e) {
		e.preventDefault();
		$('#new_card_form').fadeToggle();
	});

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