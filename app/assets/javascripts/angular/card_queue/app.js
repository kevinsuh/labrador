(function() {

  var app = angular.module('card-queue', ['manage-recipients', 'ngAnimate', 'ngMessages', 'ui.router', 'templates', 'vr.directives.nlForm', 'angularSpinner', 'fancyboxplus', 'angular-click-outside', 'calendarApp']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider, usSpinnerConfigProvider) {

    // default spinner configurations
    usSpinnerConfigProvider.setDefaults({radius:36, width:8, length: 33, lines: 15, speed: 1.4, scale: 0.4});

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/',
        abstract: true,
				templateUrl: "angular/card_queue/home.html"
      })
      .state('root.greeting_central', {
        controller: 'CardQueueController',
        abstract: true,
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
      .state('root.greeting_central.step1', {
        url: '',
        replace: true,
        templateUrl: "angular/card_queue/form_step_one.html"
      })

      .state('root.greeting_central.step2', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_two.html"
      })

      .state('root.greeting_central.step3', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_three.html"
      })

      .state('root.greeting_central.step4', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_four.html",
      })

      .state('root.greeting_central.step5', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_five.html"
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



