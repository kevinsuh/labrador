(function() {

  var app = angular.module('manage-recipients', ['ngAnimate', 'ngMessages', 'ui.router', 'templates', 'fancyboxplus', 'ui.bootstrap', 'countrySelect']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
      .state('my_people', {
        url: '/my_people/',
        abstract: true,
        templateUrl: "angular/manage_recipients/home.html"
      })
      .state('my_people.app', {
        controller: "ManageRecipientsController",
        abstract: true,
        views: {
          'card_view': {
            templateUrl: "angular/manage_recipients/card_view.html"
          } 
        }
      })
      .state('my_people.app.card_view', {
        url: '',
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

  });

})();
