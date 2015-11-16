// factory method to CRUD occasions
(function(){
  
  angular.module('manage-recipients').factory('occasions', ['$http', function($http) {

    var o = {
      currentOccasions: [], // one array of all occasions associated with the user
      currentOccasionsByRecipient: [], // segmented by the recipient. an array of array of recipient_occasion objects
      newOccasion: {
        day: "",
        month: "",
        notes: "",
        occasion_id: 7,
        recipient_id: "",
        occasion: {},
        recipient: {}
      },
      newOccasionTemplate: {
        day: "",
        month: "",
        notes: "",
        occasion_id: 7,
        recipient_id: "",
        occasion: {},
        recipient: {}
      },
      selectedOccasions: [], // actual objects of what we're quering for
      selectedOccasionIDs:[] // IDs for the occasions
    }

    // get all occaisons associated with current user
    o.getCurrentOccasions = function() {
      return $http.get('/occasions/get_current_occasions.json').success(function(data) {

        var occasionsByRecipient = data.occasions;
        o.currentOccasionsByRecipient = occasionsByRecipient;

        var occasions = [];
        for (var i = 0; i < occasionsByRecipient.length; i++) {
          for (var j = 0; j < occasionsByRecipient[i].length; j++) {
            occasions.push(occasionsByRecipient[i][j]);
          }
        }

        o.currentOccasions = occasions;

      })
    }

    o.createOccasion = function(occasion) {
      return $http.post('occasions/create_for_current.json', occasion)
    }

    o.updateOccasion = function(occasion) {
      return $http.post('occasions/update_for_current.json', occasion)
    }

    o.deleteOccasion = function(occasion) {
      return $http.post('occasions/delete_for_current.json', occasion)
    }

    // pass in an array of recipientIDs to delete
    o.deleteOccasions = function(occasionIDs) {
      return $http.post('occasions/delete_selected_occasions.json', {occasion_ids: occasionIDs});
    }

    return o;    

  }]);

})();

