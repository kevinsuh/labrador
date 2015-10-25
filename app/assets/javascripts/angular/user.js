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

    o.updateAddress = function(address) {
      return $http.post('/checkout/addresses/update_json.json', address);
    };

    o.createAddress = function(address) {
      return $http.post('/checkout/addresses/create_json.json', address);
    };

    o.updatePayment = function(payment) {
      return $http.post('/checkout/payment_cards/update_json.json', payment);
    };

    o.createPayment = function(payment, shippingAddress) {
      payment_object = {
        payment: payment,
        shipping_address: shippingAddress
      }
      // we need shipping address if user wants billing to be same as shipping address
      return $http.post('/checkout/payment_cards/create_json.json', payment_object);
    }

    return o;    

  }]);

})();

