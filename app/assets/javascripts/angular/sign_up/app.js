(function() {

  var app = angular.module('sign-up', ['ngAnimate', 'ngMessages', 'ui.router', 'templates']);

  app.config(function($stateProvider, $urlRouterProvider, $locationProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('form', {
        url: '/form',
        abstract: true,
				templateUrl: "angular/sign_up/sign_up_form.html",
				controller: 'SignUpController',
      })

      .state('form.profile', {
        url: '',
        templateUrl: "angular/sign_up/_basic_sign_up.html"
      })

      .state('form.address', {
        templateUrl: "angular/sign_up/_address_sign_up.html"
      })

      .state('form.interests', {
        templateUrl: "angular/sign_up/_interests_sign_up.html"
      });

    $urlRouterProvider.otherwise('/form');
		


  });

})();



