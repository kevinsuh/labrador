$(document).on('ready page:load', function() {

	// show new address form
	$('#new_address').click(function(e) {
		e.preventDefault();
		var address_divs = $('.address_form_div');
		address_divs.each(function() {
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
		var address_id = $(this).data('address-id');
		var address_divs = $('.address_form_div');
		address_divs.each(function() {
			if ($(this).data('address-id') == address_id) {
				$(this).fadeToggle();		
			}
		});
	});

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