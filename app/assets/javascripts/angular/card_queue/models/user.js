// factory method to get user info
// we need to pass in user-info to the app module
(function(){
  
  angular.module('card-queue').factory('user', ['$http', function($http) {
    
    // the user object
    var o = {
      gravatar_url: "",
      email: ""
    };

    /**
     * return the current user info object in JSON
     */
    o.getCurrentUserInfo = function() {
      return $http.get('/users/current_user_info.json')
      .success(function(data) {
        var user       = data.user;
        o.gravatar_url = user.gravatar_url
        o.email        = user.email;
      });
    }
    
    return o;    

  }]);

})();

