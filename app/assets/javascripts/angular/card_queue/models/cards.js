// factory method to create cards
(function(){
  
  /**
   * this will have an array of card objects. each time you fill out a form, you will be creating a new card object. when you submit it successfully, it will clone and add the object to the array of cards for future use.
   * you can then empty out the card objet to put in new information before submitting it again
   */
  angular.module('card-queue').factory('cards', ['$http', function($http) {
    
    /**
     * current model is to have an array of cards that gets pushed to as you create a new card. the newCard is an empty object that contain the card object as you continue to fill out the form. once it finishes validation, angular will clone the card into an object, then push it onto the array of newCards, which will push down a div for each newCard that gets added
     * after submit, newCard will empty out so that a new process can start again
     */
    var o = {
      deliveredCards: [],
      purchasedCards: [],
      queuedCards:[],
      newCard: {
        occasionType: "",
        recipientRelationship: "",
        recipientFirstName: "",
        recipientLastName: "",
        recipientGender: "",
        recipientArrivalDate: "", // what day does recipient need to get this?
        cardFlavors: "",
        cardImage: "",
        cardID: 1, // which card did user select?
        preAddress: "",
        recipientAddress: "",
        notes: ""
      },
      occasions: {},
      test: "hello world!!~"
    };

    /** submit a new card */
    o.queueCard = function() {
      return $http.post('/queue_card.json', o.newCard);
    }

    o.getOccasions = function() {
      return $http.get('/get_occasion_types.json').success(function(data) {
        var occasions = data.occasions;
        var occasion;
        for (var index in occasions) {
          occasion = occasions[index];
          o.occasions[occasion.occasion_name] = occasion.id;
        }
      });
    }

    return o;    

  }]);

})();

