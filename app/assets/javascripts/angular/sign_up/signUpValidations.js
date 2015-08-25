// directives that will handle custom form validations
(function() {
	
	var app = angular.module('sign-up');


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
        // so basically, anytime the otherModelValue changes, this will get called to compare as well
        // so, since this directive is placed on password_confirmation input field, anytime password field (aka otherModelValue) value changes, this ngModel (password_confirmation) will get tested for validation, which includes the compareTo custom validation. Boom!
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
				
				// basically what this does is, make the validation true the second user types new email, and the error will instead be handled from the DB for this instance on user clicking submit
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