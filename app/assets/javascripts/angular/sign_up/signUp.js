// factory method to create users
(function(){
  
  angular.module('sign-up').factory('signUp', ['$http', function($http) {
  
    // the information we are populating to create a user
    // have it be OPTIONAL to save an address   
    var o = {
      user: {
        first_name: "",
        last_name: "",
        email: "",
        password: "",
        password_confirmation: ""
      },
      address: {
        first_name: "",
        last_name: "",
        street: "",
        suite: "",
        city: "",
        state: "",
        zipcode: ""
      }
    };

    // how does user sign-up work? it should submit all at once for sure.
    // but how do we confirm the information as we go?
    // each time user presses "next", it must go into DB and CONFIRM that it is valid, before going on.
    // so just have a confirm_basic, confirm_address, etc...

    o.validateAndSubmit = function(user) {
      return $http.post('/users/signup_user.json', user);
    };

    o.validateAddress = function(address) {
      return $http.post('/users/validate_address.json', address);
    };

    /** SUBMIT THE FORM!!! */
    o.submit = function() {
      return $http.post('/users/create_signup.json', o);
    }

    // not using these in current design
    // o.createBasic = function(user) {
    //   return $http.post('/basic.json', user);
    // };

    // o.createAddress = function(user) {
    //   return $http.post('/address.json', user);
    // };

    // o.createInterests = function(user) {
    //   return $http.post('/interests.json', user);
    // };

    o.getInfo = function() {
      return $http.get('/user/'+user.id+'/')
    };

    return o;    

  }]);

})();

