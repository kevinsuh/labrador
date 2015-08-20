(function() {
	
	/**
	 * this controller is specific to queuing up the cards through an awesome multi-step form, then saving the data and queueing up another card
	 */
	var app = angular.module('card-queue').controller("CardQueueController", function($rootScope, $scope, $state, cards) {
			
			$scope.test = cards.test;
			$scope.newCard = cards.newCard;
			$scope.item="hello";

			$scope.takeFunction = function(key) {
				console.log(key);
			}
			console.log($scope.item);
			
	});

})();

