(function() {
	
	/**
	 * this controller is specific to queuing up the cards through an awesome multi-step form, then saving the data and queueing up another card
	 */
	var app = angular.module('card-queue').controller("CardQueueController", function($rootScope, $scope, $state, cards) {
			
			$scope.test = cards.test;
			$scope.newCard = cards.newCard;
			$scope.newCardReal = cards.newCardReal;
			
			// new angular nl method
			$scope.occasions = [
				"Christmas",
				"Birthday",
				"Thank You",
				"Anniversary"
			];


			// // this will be in the "cards" factory
			// $scope.listItems = {
			// 	chr: "Christmas",
			// 	bd: "Birthday",
			// 	ty: "Thank You",
			// 	jb: "Just because"
			// };
			// $scope.currentItem = $scope.listItems.bd;

			// // this is to control the NL form
			// $scope.occasionFieldOpen = false;
			// $scope.occasionFieldOpenToggle = function(key) {
			// 	if (key) {
			// 		$scope.currentItem = $scope.listItems[key];
			// 	}
			// 	$scope.occasionFieldOpen = !$scope.occasionFieldOpen;
			// }

			
	});

})();

