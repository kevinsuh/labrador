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
      purchasedCards: [], // purchased but not yet delivered
      queuedCards:[], // queued but not purchased
      selectedCardsForPurchase: [], // cards that user is trying to check out with
      newCard: { // current card being filled out
        occasion: "",
        recipientRelationship: "",
        recipientFirstName: "",
        recipientLastName: "",
        recipientArrivalDate: "", // when does recipient need to get this?
        curatedCards: {}, // cards to choose from
        selectedCard: {}, // which card did user select?
        preAddress: "",
        recipientAddress: "",
        notes: ""
      },
      newCardTemplate: { // get the blank version of the card
        occasion: "",
        recipientRelationship: "",
        recipientFirstName: "",
        recipientLastName: "",
        recipientArrivalDate: "", // when does recipient need to get this?
        curatedCards: {}, // cards to choose from
        selectedCard: {}, // which card did user select?
        preAddress: "",
        recipientAddress: "",
        notes: ""
      },
      occasionCards: {}, // all cards for an occasion
      selectableCards: {}, // cards that user can select from
      occasions: {},
      relationships: {},
      cardFlavors: {}
    };

    /**
     * submit the card for queueing
     */
    o.queueCard = function(selectedCard, selectedRecipients, occasionID, recipientArrivalDate) {
      selectedCardObject = { selected_card: selectedCard, selected_recipients: selectedRecipients, occasion_id: occasionID, recipient_arrival_date: recipientArrivalDate };
      return $http.post('orders/queue_card_order.json', selectedCardObject);
    }
        
    /**
     * using search info, find the appropriate cards for user to select from
     */
    o.getCuratedCards = function() {
      return $http.post('/cards/get_curated_cards.json', o.newCard).success(function(data) {
        var cards = data.cards; // array of card objects
        o.newCard.curatedCards = cards;
      });
    }

    /**
     * get all the cards for a specific occasion
     * current use-case is for when user selects a specific occasion. defaults to birthday.
     */
    o.getCardsForOccasion = function(occasionID) {
      return $http.post('/cards/get_cards_for_occasion.json', {occasion_id: occasionID}).success(function(data) {
        var cards = data.cards;
        o.occasionCards = cards;
      })
    }

    o.getOccasions = function() {
      return $http.get('/occasions/get_occasions.json').success(function(data) {
        var occasions = data.occasions;
        var occasion;
        for (var index in occasions) {
          occasion = occasions[index];
          o.occasions[occasion.name] = occasion.id;
        }
      });
    }

    o.getCardFlavors = function() {
      return $http.get('/cards/get_flavors.json').success(function(data) {
        var cardFlavors = data.cards;
        var cardFlavor;
        for (var index in cardFlavors) {
          cardFlavor = cardFlavors[index];
          o.cardFlavors[cardFlavor.name] = cardFlavor.id;
        }
      });
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

    /**
     * get the cards via the array of ids pased in
     * @param  int array cardIDs
     */
    o.getOrdersForIDs = function(orderIDs) {

      return $http.post('/orders/get_selected_orders.json', {selected_order_ids: orderIDs })
      .success(function(data) {
        console.log("in get orders for ids");
        console.log(data);
        orders = data.orders;
        o.selectedCardsForPurchase = orders;
      });

    }

    return o;    

  }]);

})();

