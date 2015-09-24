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
        first_name: "",
        last_name: "",
        relationship: {
          id: 1,
          name: ""
        },
        primary_address: {
          street: "",
          city: "",
          state: "",
          zipcode: "",
          country: "United States"
        },
        occasions: [] // the various "events" attached to this recipient
      },
      newRecipientTemplate: {
        first_name: "",
        last_name: "",
        relationship: {
          id: 1,
          name: ""
        },
        primary_address: {
          street: "",
          city: "",
          state: "",
          zipcode: "",
          country: "United States"
        },
        occasions: [] // the various "events" attached to this recipient
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
      return $http.get('/recipients/get_current_recipients.json').success(function(data) {
        var recipients = data.recipients;
        o.currentRecipients = recipients;
      })
    }

    o.createRecipient = function() {
      return $http.post('recipients/create_for_current.json', o.newRecipient)
    }

    o.updateRecipient = function(recipient) {
      return $http.post('recipients/update_for_current.json', recipient)
    }

    return o;    

  }]);

})();

