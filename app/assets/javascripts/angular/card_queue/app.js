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
        abstract: true,
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
      })

      .state('home.app.step1', {
        url: '',
        templateUrl: "angular/card_queue/form_step_one.html"
      })

      .state('home.app.step2', {
        templateUrl: "angular/card_queue/form_step_two.html"
      })

      .state('home.app.step3', {
        templateUrl: "angular/card_queue/form_step_three.html"
      })

      .state('home.app.step4', {
        templateUrl: "angular/card_queue/form_step_four.html"
      });

    $urlRouterProvider.otherwise('/');

  });

})();



