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
				templateUrl: "angular/card_queue/home.html",
        resolve: {
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUser();
          }]
        }
      })
      .state('main.app', {
        controller: "MainController",
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
        },
        resolve: {
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
        }
      })
      .state('main.app.my_people', {
        views: {
          'container@main': {
            templateUrl: "angular/manage_recipients/home.html"
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
      })
      .state('main.app.my_people.home', {
        controller: "ManageRecipientsController",
        url: '/my_people',
        views: {
          'card_view': {
            templateUrl: "angular/manage_recipients/card_view.html"
          }
        }
      })
      .state('queue', {
        url: '/queue_card',
        abstract: true,
        templateUrl: "angular/queue_wizard/home.html",
        resolve: {
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUser();
          }]
        }
      })
      .state('queue.home', {
        url: '/:recipients',
        views: {
          'recipients': {
            templateUrl: "angular/queue_wizard/recipients.html"
          },
          'wizard': {
            templateUrl: "angular/queue_wizard/wizard.html"
          }
        },
       resolve: {
          occasionPromise: ['cards', function(cards) {
            return cards.getOccasions();
          }],
          recipient_ids: ['$stateParams', function($stateParams) {
            // turn string into array
            recipient_ids = $stateParams.recipients.split(",");
            console.log(recipient_ids);
            return recipient_ids;
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



