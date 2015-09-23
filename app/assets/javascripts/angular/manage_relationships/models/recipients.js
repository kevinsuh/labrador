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
        firstName: "kevin",
        lastName: "suh",
        relationship: "2",
        primary_address: {
          street: "2704 sw 311th st",
          city: "fw",
          state: "wa",
          zipcode: "98023",
          country: "United States"
        }
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
      return $http.get('/relationships/get_current_recipients.json').success(function(data) {
        var recipients = data.relationships;
        o.currentRecipients = recipients;
      })
    }

    // get address of the person
    // do i need this?
    o.getAddress = function(person) {

    }

    return o;    

  }]);

})();

