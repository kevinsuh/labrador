(function() {

  var app = angular.module('card-queue', ['ngAnimate', 'ngMessages', 'ui.router', 'templates']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/',
				templateUrl: "angular/card_queue/home.html",
				controller: 'CardQueueController',
      })

      .state('queue', {
        views: {
          'form': {

          },
          'history': {

          },
          'checkout': {

          }
        }
      });

    $urlRouterProvider.otherwise('/');

  });

})();



