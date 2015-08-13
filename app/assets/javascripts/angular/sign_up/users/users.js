// factory method to create users
(function(){
	
	angular.module('sign-up').factory('user', ['$http', function($http) {
  
    // the information we are populating to create a user
    // have it be OPTIONAL to save an address		
		var user = {
			name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      shippingFirstName: "",
      shippingLastName: "",
      street: "",
      suite: "",
      city: "",
      state: "",
      zipcode: ""
		};

    // how does user sign-up work? it should submit all at once for sure.
    // but how do we confirm the information as we go?
    // each time user presses "next", it must go into DB and CONFIRM that it is valid, before going on.
    // so just have a confirm_basic, confirm_address, etc...

    user.createBasic = function(user) {
      return $http.post('/basic.json', user);
    };

    user.createAddress = function(user) {
      return $http.post('/address.json', user);
    };

    user.createInterests = function(user) {
      return $http.post('/interests.json', user);
    };

    user.getInfo = function() {
      return $http.get('/user/'+user.id+'/')
    };

		return user;

	}]);

})();

