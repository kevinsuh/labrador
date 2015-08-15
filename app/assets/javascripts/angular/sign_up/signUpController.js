(function() {
	
	var app = angular.module('sign-up').controller("SignUpController", ['$rootScope', '$scope', '$state', '$window', 'signUp', function($rootScope, $scope, $state, $window, signUp) {

		$scope.user             = signUp.user;
		$scope.address          = signUp.address;
		$scope.window           = $window;

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
		$scope.validateBasicFields = function() {

			user = signUp.user;

			// pass in the user object
			signUp.validateBasic(user)
			.success(function(data) {

				var user = data.user;
        var isValid = user.is_valid;


        if (isValid) {
        	// continue to next page
          $state.go('form.address');
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

		/**
		 * submit the form!
		 * first, we do a validation one last time to check the fields are valid, and if they are not, we will inform the user which ones are not valid
		 * it will highlight the bullet that contains inaccurate section, and also the field that is inaccurate with appropriate error message
		 */
		// redirect using angular, or using rails? think about this one.
    // probably angular, because we will need to validate the form submit and then submit the user
		$scope.submitSignupForm = function() {

			signUp.submit()
			.success(function(data) {

				var user = data.user;
        var isValid = user.is_valid;

        if (isValid) {
        	// user is logged in and now at home page
          $scope.window.location.href= "/";
        } else {
        	// must handle not valid eventually
        	alert("Something went wrong. Is your form completely filled out?");
        }

			})
			.error(function(data) {
				console.log("error in submitSignupForm");
				console.log(data);
			});

		}
		

	}]);

	// used to compare two fields
	// this is a directive that you place ON the password_confirmation field -- making it the scope of this directie
	app.directive('compareTo', function() {
    return {
      require: "ngModel",
      scope: {
      	otherModelValue: "=compareTo"
      },
      link: function(scope, element, attributes, ngModel) {
         
        // custom validator for ngModel
        ngModel.$validators.compareTo = function(modelValue) {
          return modelValue == scope.otherModelValue;
        };

        // $watch is listener callback to scope, that calls the function whenever that expression changes (i.e. watchExpression => 'otherModelValue' => user.password (in DOM))
        // this is done in this directive's isolated scope, which through 2-way data binding, got the user.password passed in via compare-to attribute to the tag that this directive is attached to. it then gets called as scope's otherModelValue property
        scope.$watch("otherModelValue", function() {
            ngModel.$validate();
        });
      }
    };
	});

	// used to validate password from front-end
	// currently only just minimum 6 characters that includes one number
	app.directive('validatePassword', function() {
		return {
			require: "ngModel",
			link: function(scope, element, attributes, ngModel) {

				// minimum length
				ngModel.$validators.sixCharacters = function (value) {
					return (typeof value != 'undefined') && value.length >= 6;
				}

				// includes one number
				ngModel.$validators.number = function (value) {
					var pattern = /\d+/;
					return (typeof value != 'undefined') && pattern.test(value);
				}
			}
		}
	});

	// currently just for taken emails, but can expand from there
	app.directive('validateEmail', function() {
		return {
			require: "ngModel",
			link: function(scope, element, attributes, ngModel) {
				// email taken, which can only be tested via DB
				ngModel.$validators.emailTaken = function (value) {
					return true;
				}

				// email uniqueness validation goes away for new attempts
				element.bind('keydown', function() {
					for (var prop in ngModel.$error) {
						if (prop == "email-taken") {
							ngModel.$setValidity(prop, true);
						}
					}
				})
			}
		}
	});

})();

