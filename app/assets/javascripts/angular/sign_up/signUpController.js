(function() {
	
	var app = angular.module('sign-up').controller("SignUpController", function($rootScope, $scope, $state, $window, signUp) {

		$scope.user             = signUp.user;
		$scope.address          = signUp.address;
		$scope.window           = $window;

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

		/**
		 * validate that the user can be created
		 * email + password + password_confirmation
		 */
		$scope.submitSignupForm = function() {

			user = signUp.user;

			// pass in the user object
			signUp.validateAndSubmit(user) // currently this CREATES USER
			.success(function(data) {
				console.log(data);

				var user = data.user;
        var isValid = user.is_valid;

        if (isValid) {
        	// continue to next page
        	// currently, just go straight to root url
        	$scope.window.location.href= "/";
          //$state.go('form.address');
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
				console.log("error in validateBasicFields");
				console.log(data);
			});
		}

		// currently we aren't taking address or interests, but this may become used later on.

		/**
		 * validate that the user's address can be created!
		 * first_name, last_name, street, suite, city, state, zipcode
		 */
		$scope.validateAddressFields = function() {

			address = signUp.address;

			signUp.validateAddress(address)
			.success(function(data) {

				var address = data.address;
        var isValid = address.is_valid;


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
				console.log("error in validateAddressFields");
				console.log(data);
			});

		}

	});

})();

