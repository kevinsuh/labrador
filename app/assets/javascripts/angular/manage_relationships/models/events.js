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
      currentEvents: [], // already existing events for all recipients
      currentEventsForCalendar: [] // format existing events for calendar
    }

    // get list of your current saved events/occasions
    o.getCurrentOccasions = function() {
      return $http.get('/recipient_occasions/get_occasions_for_current.json').success(function(data) {
        console.log("hi");
        console.log(data);
        var recipient_occasions = data.recipient_occasions;
        o.currentEvents = recipient_occasions;

        // format occasions for calendar
        o.formatOccasionsForCalendar();
      });
    };

    // this formats your events for the calendar
    o.formatOccasionsForCalendar = function() {

      var date = new Date();
      var d = date.getDate();
      var m = date.getMonth();
      var y = date.getFullYear();

      var events = o.currentEvents;
      var formattedEvents = [];

      events.forEach(function(event) {
        event_data = {};

        event_data["id"]        = event.id;
        event_data["start"]     = new Date(event.occasion_date);
        event_data["className"] = "glyphicon glyphicon-menu-down"
        event_data["allDay"]    = true;
        event_data["extra"]     = event

        formattedEvents.push(event_data);
      });

      o.currentEventsForCalendar = formattedEvents;
    };

    return o;    

  }]);

})();

