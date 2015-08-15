(function() {
	
	var app = angular.module('sign-up').controller("SignUpController", ['$rootScope', '$scope', '$state', 'signUp', function($rootScope, $scope, $state, signUp) {

		$scope.user    = signUp.user;
		$scope.address = signUp.address;
		$scope.basicError = false;

		$scope.$on('$stateChangeSuccess',
		  function(event, toState) {
		    $scope.currentState = toState.name;
		  }
		)

		// bool to test if form field has been touched
		$scope.showMessages = function(field) {
			return $scope.basicInfoForm[field].$touched || $scope.basicInfoForm.$submitted;
		};

		// bool to test if form field has error
		$scope.hasError = function(field) {
			return $scope.basicInfoForm[field].$touched && $scope.basicInfoForm[field].$invalid;
		};

		// test if form field is valid AFTER user has finished typing
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

		// validate that user can be created via
		// email + password + password_confirmation
		$scope.validateBasicFields = function() {

			user = $scope.user;

			// pass in the user object
			signUp.validateBasic(user)
			.success(function(data) {

				var user = data.user;
        var isValid = user.is_valid;


        if (isValid) {
        	// continue to next page
          console.log("yay the data is valid so far!")
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
				console.log("error");
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

