(function() {
	
	var app = angular.module('sign-up').controller("SignUpController", function($rootScope, $scope, $state, $window, signUp) {

		// attach address to user
		$scope.user         = signUp.user;
		$scope.user.address = {};
		$scope.window       = $window;

		// get the early access email
		earlyAccessEmailElement = angular.element(document.querySelector("#early_access_email"));
		$scope.user.email = earlyAccessEmailElement.val();

		$scope.$on('$stateChangeSuccess',
		  function(event, toState) {
		    $scope.currentState = toState.name;
		  }
		)

		$scope.showMessages = function(field) {
			return $scope.basicInfoForm[field].$touched || $scope.basicInfoForm.$submitted;
		};

		// bool to whether form field has error
		$scope.hasError = function(field) {
			return $scope.basicInfoForm[field].$touched && $scope.basicInfoForm[field].$invalid;
		};

		// whether form field is valid AFTER user has finished typing
		$scope.isValid = function(field) {
			return $scope.basicInfoForm[field].$touched && $scope.basicInfoForm[field].$valid;
		}

		// handle specific password requirements
		$scope.passwordError = function(error) {
			if (error.sixCharacters) {
				return $scope.basicInfoForm['password'].$touched;	
			}
			else if (error.number) {
				return $scope.basicInfoForm['password'].$touched;
			};
		}

		// array of form fields must all be valid to be true
		$scope.fieldsAreValid = function(fields) {
			var valid = true;

			for (var i = 0; i < fields.length; i++) {
				if ($scope.basicInfoForm[fields[i]].$invalid) {
					valid = false;
				}
					
			}
			return valid; 
		}

		// currently we aren't taking address or interests, but this may become used later on.

		/**
		 * validate that the user's address can be created!
		 * first_name, last_name, street, suite, city, state, zipcode
		 */
		$scope.createBasicInfo = function() {

			// combine the user and address
			user         = signUp.user;

			// pass in the user object
			signUp.validateBasicInfoAndSubmit(user) // currently this CREATES USER
			.success(function(data) {
				
				console.log(data);

				var user = data.user;
        var isValid = user.is_valid;

        if (isValid) {
        	// continue to next page
        	$state.go('form.interests');
        } else {
        	// tell the error and prevent continuing on
        	// for now we will only do the first one, should be more dynamic in the future though
        	$scope.basicError = true;
        	var errorField = user.error_field;
        	var errorReason = user.error_reason;
        	$scope.basicInfoForm[errorField].$setValidity(errorReason, false);
        }

			})
			.error(function(data) {
				console.log("error in createBasicInfo");
				console.log(data);
			});
		}

		$scope.createAdvancedInfo = function() {
			// combine the user and address
			user         = signUp.user;

			// pass in the user object
			signUp.validateAdvancedInfoAndSubmit(user) // currently this CREATES USER
			.success(function(data) {
				
				console.log(data);

				var user = data.user;
        var isValid = user.is_valid;

        if (isValid) {
        	// continue to next page
        	$scope.window.location.href= "/beta_thank_you";
        } else {
        	// tell the error and prevent continuing on
        	// for now we will only do the first one, should be more dynamic in the future though
        	$scope.basicError = true;
        	var errorField = user.error_field;
        	var errorReason = user.error_reason;
        	$scope.basicInfoForm[errorField].$setValidity(errorReason, false);
        }

			})
			.error(function(data) {
				console.log("error in createAdvancedInfo");
				console.log(data);
			});
		}

	});

})();

