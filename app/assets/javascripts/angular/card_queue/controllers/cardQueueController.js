(function() {
	
	/**
	 * this controller is specific to queuing up the cards through an awesome multi-step form, then saving the data and queueing up another card
	 */
	var app = angular.module('card-queue').controller("CardQueueController", function($rootScope, $scope, $state, cards) {
			
			$scope.test = cards.test;
			$scope.newCard = cards.newCard;
			$scope.newCardReal = cards.newCardReal;

			// new angular nl method
			$scope.occasions = {
				"Christmas": 1,
				"Hannukkah": 2,
				"New Year's": 3,
				"Mother's Day": 4,
				"Father's Day": 5,
				"Anniversary": 6,
				"Birthday": 7,
				"Injury/Sick": 8,
				"Graduation": 9,
				"New Job": 10,
				"Thank You": 11
			};

			$scope.relationships = {
				Mother: 1,
				Father: 2,
				Sister: 3,
				Brother: 4,
				"Significant other (male)": 5,
				"Significant other (female)": 6,
				"Friend (male)": 7,
				"Friend (female)": 8,
				Grandmother: 9,
				Grandfather: 10,
				Mentor: 11
			};

			$scope.months = {
				January: 1,
				February: 2,
				March: 3,
				April: 4,
				May: 5,
				June: 6,
				July: 7,
				August: 8,
				September: 9,
				October: 10,
				November: 11,
				December: 12
			};

			$scope.cardFlavors = {
				"funny": 1,
				"witty": 2,
				"charming": 3,
				"cute": 4,
				"genuine": 5,
				"crazy": 6
			}

			// collect month, then make it into a datetime obj
			$scope.date = {
				month: "",
				day: "",
				year: ""
			}

			// don't allow more than 3 card flavors!
			$scope.$watch('newCardReal.cardFlavors.length', function(newValue, oldValue){
          if (newValue > 3) {
          	$scope.newCardReal.cardFlavors.shift();
          }
        }
	    );


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

