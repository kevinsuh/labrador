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
        occasions: [], // the various "events" attached to this recipient
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
        occasions: [], // the various "events" attached to this recipient
      },
      relationships: {}, // list of relationship types
      selectedRecipients: [], // actual objects for who we're queueing for
      selectedRecipientIDs:[] // IDs for the URL
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

    o.deleteRecipient = function(recipient) {
      return $http.post('recipients/delete_for_current.json', recipient)
    }

    // pass in an array of recipientIDs to delete
    o.deleteRecipients = function(recipientIDs) {
      return $http.post('recipients/delete_selected_recipients.json', {recipient_ids: recipientIDs});
    }

    /**
     * start queue card process for recipients
     */
    o.queueCardForRecipients = function() {
      return $http.post('/queue_card', o.selectedRecipients);
    }
    o.retrieveRecipients = function(recipient_ids) {
      return $http.post("recipients/get_recipients.json", {recipient_ids: recipient_ids}).success(function(data) {
        o.selectedRecipients = data.recipients
      });
    }

    // successful picture upload -- update the proper recipient in this factor
    o.updatePictureOnSuccess = function(recipient) {
      currentRecipients = o.currentRecipients;
      index = findWithAttr(currentRecipients, 'id', recipient.id);
      o.currentRecipients[index] = recipient;
      console.log(o.currentRecipients);
    }

    return o;    

  }]);

})();

