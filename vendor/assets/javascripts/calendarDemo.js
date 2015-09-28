/**
 * calendarDemoApp - 0.9.0
 */
var calendarDemoApp = angular.module('calendarDemoApp', ['ui.calendar', 'ui.bootstrap']);

calendarDemoApp.controller('CalendarCtrl',
   function($scope, $compile, $timeout, uiCalendarConfig, recipients) {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();

    $scope.changeTo = 'Hungarian';
    $scope.currentRecipients = recipients.currentRecipients;
    /* event source that pulls from google.com */
    $scope.eventSource = {
            url: "http://www.google.com/calendar/feeds/usa__en%40holiday.calendar.google.com/public/basic",
            className: 'gcal-event',           // an option!
            currentTimezone: 'America/Chicago' // an option!
    };
    /* event source that contains custom events on the scope */
    $scope.events = [
      {id: 444, start: new Date(y, m, d + 1, 19, 0), className: "glyphicon glyphicon-menu-down", allDay: true}
    ];

// {title: 'All Day Event',start: new Date(y, m, 1)},
//       {title: 'Long Event',start: new Date(y, m, d - 5),end: new Date(y, m, d - 2)},
//       {id: 999,title: 'Repeating Event',start: new Date(y, m, d - 3, 16, 0),allDay: false},
//       {id: 999,title: 'Repeating Event',start: new Date(y, m, d + 4, 16, 0),allDay: false},
//{title: recipients.currentRecipients[0].occasions[0].recipient_occasion.occasion_date,start: new Date(y, m, 28),end: new Date(y, m, 29),url: 'http://google.com/'},
    console.log(recipients.currentRecipients);

    /* event source that calls a function on every view switch */
    $scope.eventsF = function (start, end, timezone, callback) {
      var s = new Date(start).getTime() / 1000;
      var e = new Date(end).getTime() / 1000;
      var m = new Date(start).getMonth();
      var events = [{title: 'Feed Me ' + m,start: s + (50000),end: s + (100000),allDay: false, className: ['customFeed']}];
      callback(events);
    };

    $scope.calEventsExt = {
       color: '#f00',
       textColor: 'yellow',
       events: [
          {type:'party',title: 'Lunch',start: new Date(y, m, d, 12, 0),end: new Date(y, m, d, 14, 0),allDay: false},
          {type:'party',title: 'Lunch 2',start: new Date(y, m, d, 12, 0),end: new Date(y, m, d, 14, 0),allDay: false},
          {type:'party',title: 'Click for Google',start: new Date(y, m, 28),end: new Date(y, m, 29),url: 'http://google.com/'}
        ]
    };
    /* alert on eventClick */
    $scope.alertOnEventClick = function( date, jsEvent, view){
        $scope.alertMessage = (date + ' was clicked ');
    };
    /* alert on Drop */
     $scope.alertOnDrop = function(event, delta, revertFunc, jsEvent, ui, view){
       $scope.alertMessage = ('Event Dropped to make dayDelta ' + delta);
    };
    /* alert on Resize */
    $scope.alertOnResize = function(event, delta, revertFunc, jsEvent, ui, view ){
       $scope.alertMessage = ('Event Resized to make dayDelta ' + delta);
    };

    /* add and removes an event source of choice */
    $scope.addRemoveEventSource = function(sources,source) {
      var canAdd = 0;
      angular.forEach(sources,function(value, key){
        if(sources[key] === source){
          sources.splice(key,1);
          canAdd = 1;
        }
      });
      if(canAdd === 0){
        sources.push(source);
      }
    };
    /* add custom event*/
    $scope.addEvent = function() {
      $scope.events.push({
        title: 'Open Sesame',
        start: new Date(y, m, 28),
        end: new Date(y, m, 29),
        className: ['openSesame']
      });
    };
    /* remove event */
    $scope.remove = function(index) {
      $scope.events.splice(index,1);
    };
    /* Change View */
    $scope.changeView = function(view,calendar) {
      uiCalendarConfig.calendars[calendar].fullCalendar('changeView',view);
    };
    /* Change View */
    $scope.renderCalender = function(calendar) {
      $timeout(function() {
        if(uiCalendarConfig.calendars[calendar]){
          uiCalendarConfig.calendars[calendar].fullCalendar('render');
        }
      });
    };
     /* Render Tooltip */
    // $scope.eventRender = function( event, element, view ) {
    //     // element.attr({'tooltip': event.title,
    //     //               'tooltip-append-to-body': true});
    //     //$(element).attr('tooltip', "event.title");
    // };

    $scope.eventRender = function( event, element, view ) { 
      $timeout(function(){
        $(element).attr("ng-mouseover", "showPopover('"+event.id+"')");
        $(element).attr("ng-mouseleave", "hidePopover('"+event.id+"')");
        $(element).append("<div class='recipient-popover event-"+ event.id+ "' ng-show='popover"+event.id+"IsVisible'>{{currentRecipients[0].first_name}}</div>");
        $compile(element)($scope);
      });
    };

    $scope.showPopover = function(eventID) {
      
      //var popover = document.getElementsByClassName("event-"+eventID);
      //var angularPopover = angular.element(popover);
      $scope["popover"+eventID+"IsVisible"] = true;
    }

    $scope.hidePopover = function(eventID) {
      $scope["popover"+eventID+"IsVisible"] = false;
    }

    /* config object */
    $scope.uiConfig = {
      calendar:{
        height: 900,
        editable: false,
        header:{
          left: 'today prev,next',
          center: '',
          right: 'title'
        },
        eventClick: $scope.alertOnEventClick,
        eventDrop: $scope.alertOnDrop,
        eventResize: $scope.alertOnResize,
        eventRender: $scope.eventRender
      }
    };

    $scope.changeLang = function() {
      if($scope.changeTo === 'Hungarian'){
        $scope.uiConfig.calendar.dayNames = ["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"];
        $scope.uiConfig.calendar.dayNamesShort = ["Vas", "Hét", "Kedd", "Sze", "Csüt", "Pén", "Szo"];
        $scope.changeTo= 'English';
      } else {
        $scope.uiConfig.calendar.dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        $scope.uiConfig.calendar.dayNamesShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        $scope.changeTo = 'Hungarian';
      }
    };
    /* event sources array*/
    $scope.eventSources = [$scope.events, $scope.eventSource, $scope.eventsF];
    $scope.eventSources2 = [$scope.calEventsExt, $scope.eventsF, $scope.events];
});
/* EOF */
