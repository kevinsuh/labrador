(function() {

  var app = angular.module('card-queue', ['manage-recipients', 'queue-wizard', 'ngAnimate', 'ngMessages', 'ui.router', 'templates', 'vr.directives.nlForm', 'angularSpinner', 'fancyboxplus', 'angular-click-outside', 'calendarApp']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider, usSpinnerConfigProvider) {

    // default spinner configurations
    usSpinnerConfigProvider.setDefaults({radius:36, width:8, length: 33, lines: 15, speed: 1.4, scale: 0.4});

    // home page that shows lists of posts and allows you to post new ones
    $stateProvider
			.state('main', {
        url: '',
        abstract: true,
				templateUrl: "angular/card_queue/home.html"
      })
      .state('main.app', {
        abstract: true,
        views: {
          'main_header': {
            templateUrl: "angular/card_queue/main_header.html"
          },
          'main_footer': {
            templateUrl: "angular/card_queue/main_footer.html"
          },
          'main_left_bar': {
            templateUrl: "angular/card_queue/main_left_bar.html"
          }
        }
      })
      .state('main.app.greeting_central', {
        controller: 'CardQueueController',
        views: {
          'container@main': {
            templateUrl: "angular/card_queue/greeting_central.html"
          }
        }
      })
      .state('main.app.greeting_central.home', {
        url: "/",
        views: {
          'calendar': {
            templateUrl: "angular/card_queue/calendar.html"
          },
          'my_people': {
            templateUrl: "angular/card_queue/my_people.html"
          },
          'checkout': {
            templateUrl: "angular/card_queue/checkout.html"
          }
        },
        resolve: {
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUserInfo();
          }],
          occasionPromise: ['cards', function(cards) {
            return cards.getOccasions();
          }],
          relationshipPromise: ['recipients', function(recipients) {
            return recipients.getRelationships();
          }],
          cardFlavorPromise: ['cards', function(cards) {
            return cards.getCardFlavors();
          }],
          queuedCardsPromise: ['cards', function(cards) {
            return cards.getOrderedCards('queued');
          }],
          purchasedCardsPromise: ['cards', function(cards) {
            return cards.getOrderedCards('purchased');
          }],
          currentRecipientsPromise: ['recipients', function(recipients) {
            return recipients.getCurrentRecipients();
          }],
          currentEventsPromise: ['events', function(events) {
            return events.getCurrentOccasions();
          }]
        }
      })
      .state('main.app.my_people', {
        url: '/my_people',
        views: {
          'container@': {
            templateUrl: "angular/manage_recipients/home.html"
          }
        }
      })
      .state('main.app.my_people.home', {
        controller: "ManageRecipientsController",
        url: "",
        views: {
          'card_view': {
            templateUrl: "angular/manage_recipients/card_view.html"
          }
        },
        resolve: {
          currentRecipientsPromise: ['recipients', function(recipients) {
            return recipients.getCurrentRecipients();
          }],
          occasionPromise: ['cards', function(cards) {
            return cards.getOccasions();
          }],
          relationshipPromise: ['recipients', function(recipients) {
            return recipients.getRelationships();
          }]
        }
      });

    $urlRouterProvider.otherwise('/');

  });

  // temp spot for card queue directives
  // this directive holds the links for iterating through the form
  app.directive("nextStep", function() {
    return {
      templateUrl: "angular/card_queue/_form_step_links.html"
    };
  });

})();



