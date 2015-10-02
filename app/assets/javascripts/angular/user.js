// factory method to get info about user
(function(){
  
  angular.module('card-queue').factory('user', ['$http', function($http) {

    // this is a factory for user to share amongst the angular app
    var o = {
      currentUser: {},
      status: {}
    }

    // get user login
    o.getCurrentUser = function() {
      return $http.get('/users/get_current_user.json').success(function(data) {
        user = data.user;
        o.currentUser = user;
        if (user.status.logged_in) {
          o.status["logged_in"] = true;
        } else {
          o.status = data.status;
        }
      });
    };

    // allow yourself to logout
    o.logOut = function() {
      return $http.get('/logout_angular.json');
    }

    return o;    

  }]);

})();

