// factory method to create and retrieve recipients
(function(){
  
  /**
   * this will be modeled similarly to the cards factory. it will be an array of recipient objects. it will have the information with the option to update those recipients in real time
   *
   * creating a new recipient will be similar to creating a new card (in terms of the angular magic)
   */
  angular.module('manage-recipients').factory('recipients', ['$http', function($http) {

    // this is a factory that will contain, gather, create, and update your recipients in similar fashion to the card_queueing service
    var o = {
      currentRecipients: [], // already existing recipients
      newRecipient: {
        firstName: "",
        lastName: "",
        birthday: "",
        relationship: "",
        gender: ""
      }, // create a new recipient
      newRecipientTemplate: {
        firstName: "",
        lastName: "",
        birthday: "",
        relationship: "",
        gender: ""
      },
      relationships: {} // list of relationship types
    }

    // get relationship types
    o.getRelationships = function() {
      return $http.get('/relationships/get_relationships.json').
      success(function(data) {
        var relationships = data.relationships;
        var relationship;
        for (var index in relationships) {
          relationship = relationships[index];
          o.relationships[relationship.name] = relationship.id;
        }
      });
    }

    // get your list of current relationships
    o.getCurrentRecipients = function() {

    }

    /**
     * get previously ordered cards for user
     * @param  orderType string to determine what kind of cards you want (i.e. 'purchased' vs 'queued')
     */
    o.getOrderedCards = function(orderType) {

      // create the object to prepare for proper order returns
      // for now, just what order type you want
      var orderDirections = {};
      orderDirections["orderType"] = orderType;
      
      return $http.post('/orders/orders_for_user.json', orderDirections).success(function(data) {
        data["orderType"] = orderType;
        console.log(data);
        if (orderType == "queued") {
          o.queuedCards = data.orders;
        } else if (orderType == "purchased") {
          o.purchasedCards = data.orders;
        }
      });

    }

    return o;    

  }]);

})();

