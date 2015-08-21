(function() {

  var app = angular.module('card-queue', ['ngAnimate', 'ngMessages', 'ui.router', 'templates', 'vr.directives.nlForm']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/',
        abstract: true,
				templateUrl: "angular/card_queue/home.html"
      })

      .state('home.app', {
        controller: 'CardQueueController',
        url: '',
        views: {
          'form': {
            templateUrl: "angular/card_queue/form.html"
          },
          'history': {
            templateUrl: "angular/card_queue/history.html"
          },
          'checkout': {
            templateUrl: "angular/card_queue/checkout.html"
          }
        }
      });

    $urlRouterProvider.otherwise('/');

  });

})();



