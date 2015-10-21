//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.Jcrop
//= require jquery.payment.js

//= require_tree .
//= require_tree ./templates
$(document).on('ready page:load', function() {

	if (document.querySelector("#ok")) {
	document.querySelector("#ok").style.color = "Purple";
}
if (document.querySelector("#ok")) {
	document.querySelector("#ok").style.color = "Green";
}
});