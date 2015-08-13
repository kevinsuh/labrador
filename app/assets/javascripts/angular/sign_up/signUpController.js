(function() {
	
	var app = angular.module('sign-up').controller('SignUpController', ['$scope', function($scope) {

		$scope.signedUp = false;
		$scope.email = "";

		newUser = {
			email: '',
			password: '',
			confirmationPassword: '',
			firstName: '',
			lastName: '',
			street: '',
			suite: '',
			city: '',
			state: '',
			zipcode: ''
		}

		$scope.signup = function() {
			$scope.signedUp = true;
			$scope.world = "hello world!!!";
		}

		// bool to test if form field has been touched
		$scope.showMessages = function(field) {
			return $scope.basicInfoForm[field].$touched || $scope.basicInfoForm.$submitted;
		};

		// bool to test if form field has error
		$scope.hasError = function(field) {
			return $scope.basicInfoForm[field].$touched && $scope.basicInfoForm[field].$invalid;
		};

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

})();
