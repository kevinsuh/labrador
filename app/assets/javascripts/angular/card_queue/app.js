(function() {

  var app = angular.module('card-queue', ['manage-recipients', 'queue-wizard', 'ngAnimate', 'ngMessages', 'ui.router', 'ui.bootstrap.alert', 'templates', 'vr.directives.nlForm', 'angularSpinner', 'fancyboxplus', 'angular-click-outside', 'calendarApp', 'CaseFilter', 'angular-credit-cards', 'angular-stripe']);

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
      .state('main.app.queued_cards', {
        views: {
          'container@main': {
            templateUrl: "angular/queued_cards/home.html"
          }
        },
        resolve: {
          queuedCardsPromise: ['cards', function(cards) {
            return cards.getOrderedCards('queued');
          }],
          purchasedCardsPromise: ['cards', function(cards) {
            return cards.getOrderedCards('purchased');
          }],
        }
      })
      .state('main.app.queued_cards.home', {
        controller: "QueuedCardsController",
        url: '/queued_cards',
        views: {
          'queued_cards_view': {
            templateUrl: "angular/queued_cards/queued_cards_view.html"
          }
        }
      })
      .state('main.app.checkout', {
        views: {
          'container@main': {
            templateUrl: "angular/checkout/home.html"
          }
        },
        controller: "CheckoutController",
        resolve: {
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUser();
          }],
          queuedCardsPromise: ['cards', function(cards) {
            return cards.getOrderedCards('queued');
          }]
          // order_ids: ['$stateParams', function($stateParams) {
          //   // turn string into array
          //   order_ids = $stateParams.selected_order_ids.split(",");
          //   return order_ids;
          // }]
          // selectedOrdersPromise: ['orders', function(recipients) { // uses the recipient_ids that were passed in from above resolve
          //   return orders.retrieveOrders(order_ids);
          // }]
        }
      })
      .state('main.app.checkout.home', {
        url: '/checkout',
        views: {
          'cards': {
            templateUrl: "angular/checkout/cards.html"
          },
          'purchase': {
            templateUrl: "angular/checkout/purchase.html"
          }
        }
      })
      .state('queue', {
        url: '/queue_card',
        abstract: true,
        templateUrl: "angular/queue_wizard/home.html",
        controller: "QueueWizardController",
        resolve: {
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUser();
          }]
        }
      })
      .state('queue.home', {
        abstract: true,
        url: '/:recipients',
        views: {
          'recipients': {
            templateUrl: "angular/queue_wizard/recipients.html"
          },
          'recipients_header': {
            templateUrl: "angular/queue_wizard/recipients_header.html"
          },
          'wizard': {
            templateUrl: "angular/queue_wizard/wizard.html"
          },
          'wizard_header': {
            templateUrl: "angular/queue_wizard/wizard_header.html"
          }
        },
       resolve: {
          occasionPromise: ['cards', function(cards) {
            return cards.getOccasions();
          }],
          flavorPromise: ['cards', function(cards) {
            return cards.getCardFlavors();
          }],
          userInfoPromise: ['user', function(user) { // return user basic info
            return user.getCurrentUser();
          }],
          recipient_ids: ['$stateParams', function($stateParams) {
            // turn string into array
            recipient_ids = $stateParams.recipients.split(",");
            return recipient_ids;
          }],
          selectedRecipientsPromise: ['recipients', function(recipients) { // uses the recipient_ids that were passed in from above resolve
            return recipients.retrieveRecipients(recipient_ids);
          }]
        }
      })
      .state('queue.home.step1', {
        url:'',
        replace: true,
        views: {
          'form': {
            templateUrl: "angular/queue_wizard/wizard_step_one.html"
          } 
        }
      })
      .state('queue.home.step2', {
        replace: true,
        views: {
          'form': {
            templateUrl: "angular/queue_wizard/wizard_step_two.html"
          }
        }
      })
      .state('queue.home.step3', {
        replace: true,
        views: {
          'form': {
            templateUrl: "angular/queue_wizard/wizard_step_three.html"
          }
        }
      })
      .state('queue.home.step4', {
        replace: true,
        views: {
          'form': {
            templateUrl: "angular/queue_wizard/wizard_step_four.html"
          }
        }
      });

    $urlRouterProvider.otherwise('/');

  });

})();



