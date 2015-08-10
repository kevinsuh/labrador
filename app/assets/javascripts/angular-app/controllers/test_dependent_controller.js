// hook up our angular framework
(function(){
	
	var app = angular.module("TestDependentApplication", [])

	app.directive("testCards", function() {
		return {
			restrict: "E",
			controller: function() {
				this.hello = "hello chip!";
			},
			controllerAs: "dependent"
		};
	});

	app.controller("HelloController", ['$scope', '$log', function($scope, $log) {
		this.fart = "farted";
		$scope.$log = $log;
	}]);

})();