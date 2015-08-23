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
        replace: true,
        templateUrl: "angular/card_queue/form_step_one.html"
      })

      .state('home.app.step2', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_two.html"
      })

      .state('home.app.step3', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_three.html"
      })

      .state('home.app.step4', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_four.html"
      })

      .state('home.app.step5', {
        replace: true,
        templateUrl: "angular/card_queue/form_step_five.html"
      });

    $urlRouterProvider.otherwise('/');

  });

  // temp spot for card queue directives
  // this directive holds the links for iterating through the form
  app.directive("nextStep", function() {
    return {
      scope: false,
      templateUrl: "angular/card_queue/_form_step_links.html"
    };
  });

})();



