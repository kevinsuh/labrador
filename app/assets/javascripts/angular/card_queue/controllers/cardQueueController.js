(function() {
	
	/**
	 * this controller is specific to queuing up the cards through an awesome multi-step form, then saving the data and queueing up another card
	 */
	var app = angular.module('card-queue').controller("CardQueueController", ['$rootScope', '$scope', '$state', function($rootScope, $scope, $state) {
			
			$scope.test = "hello world!";
			
	}]);

})();

