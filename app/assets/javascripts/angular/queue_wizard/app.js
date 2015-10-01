(function() {

  var app = angular.module('queue-wizard', ['ngAnimate', 'manage-recipients', 'card-queue', 'ngMessages', 'ui.router', 'templates', 'fancyboxplus', 'ui.bootstrap', 'countrySelect']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
      .state('queue_wizard', {
        url: '/wizard',
        templateUrl: "angular/queue_wizard/home.html",
        abstract: true,
        controller: "QueueWizardController"
      })
      .state('queue_wizard.home', {
        url: '',
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
          }]
        }
      });
  });

})();
