//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.Jcrop
//= require jquery.payment.js
//= require angular
//= require angular-messages
//= require angular-ui-router
//= require angular-rails-templates
//= require bootstrap
//= require ui-bootstrap-tpls-0.13.4.min.js
//= require moment.min.js
//= require angular-moment.min.js
//= require calendar.js
//= require fullcalendar-2.4.0/fullcalendar.min.js
//= require fullcalendar-2.4.0/gcal.js
//= require spin.js/spin.min.js
//= require angular-spinner/angular-spinner.min.js
//= require angular-datepicker.js
//= require angular-fancybox-plus.js
//= require angular.country-select.min.js
//= require jquery.fancybox-plus.js
//= require clickoutside.directive.js
//= require angularjs-file-upload
//= require angular-animate
//= require ngImgCrop-master/compile/unminified/ng-img-crop.js
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