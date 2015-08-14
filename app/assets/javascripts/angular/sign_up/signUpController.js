(function() {
	
	var app = angular.module('sign-up').controller("SignUpController", ['$rootScope', '$scope', '$state', 'signUp', function($rootScope, $scope, $state, signUp) {

		$scope.user    = signUp.user;
		$scope.address = signUp.address;

		$scope.$on('$stateChangeSuccess',
		  function(event, toState) {
		  	console.log(toState);
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
			signUp.validateBasic(user);

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

        // this looks at password_confirmation field, where ng-model="newUser.password_confirmation"
        // it then takes that model, then calls validate, which we made a custom validator to compare it with a value we pass in (compareTo(newUser.password))
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

})();

