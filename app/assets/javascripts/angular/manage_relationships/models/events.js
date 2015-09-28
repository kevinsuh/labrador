// factory method to create and retrieve recipient occasions
(function(){
  
  /**
   * this will be modeled similarly to the cards factory. it will be an array of recipient occasion objects. it will have the information with the option to update those events in real time
   *
   * creating/updating events will be similar to creating a new card (in terms of the angular magic)
   */
  angular.module('manage-recipients').factory('events', ['$http', function($http) {

    // this is a factory that will contain, gather, create, and update your events in similar fashion to the card_queueing service
    var o = {
      currentEvents: [] // already existing events for all recipients
    }

    // get list of your current saved events/occasions
    o.getCurrentOccasions = function() {
      return $http.get('/recipients/get_current_recipients.json').success(function(data) {
        var recipients = data.recipients;
        o.currentRecipients = recipients;
      });
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

    return o;    

  }]);

})();

