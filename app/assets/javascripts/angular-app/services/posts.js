(function(){

	var app = angular.module('post-service', []);
	app.factory('posts', function() {
		// this array will persist throughout application
		var o = {
			posts: []
		};
		return o;
	});

})();