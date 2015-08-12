(function() {
	
	angular.module('sign-up').controller('BasicSignUpController', ['$scope', function($scope) {

		var ctrl = this;

		$scope.signedUp = false;
		$scope.email = "";

		this.signup = function() {
			$scope.signedUp = true;
			$scope.world = "hello world!!!";
		}

	}]);

})();
