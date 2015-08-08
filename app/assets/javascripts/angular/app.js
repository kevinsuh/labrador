// hook up our angular framework
(function(){
	
	var app = angular.module("TestApplication", [])

	app.controller('TestController', function(){
		this.test = "HELLO WORLD";
	});

})();

$(document).on('ready page:load', function() {
	angular.bootstrap(document.body, ['TestApplication']);
});
