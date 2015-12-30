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

    /**
     * now we are doing 2-step process of submitting your basic info (username, email, password)
     * second step is your address and stuff -- which we will call advanced info
     * @param  {[type]} user [description]
     * @return {[type]}      [description]
     */
    o.validateBasicInfoAndSubmit = function(user) { 
      return $http.post('/users/basic_signup.json', user);
    };

    o.validateAdvancedInfoAndSubmit = function(user) { 
      return $http.post('/users/advanced_signup.json', user);
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

