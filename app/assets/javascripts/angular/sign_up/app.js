(function() {

  var app = angular.module('sign-up', ['ngAnimate', 'ngMessages', 'ui.router', 'templates']);

  app.config(function($stateProvider, $urlRouterProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/',
				templateUrl: "angular/sign_up/_basic_sign_up.html",
				controller: 'BasicSignUpController'
        }
        );

        
    // access a speciifc post so that we can see comments and other data surrounding it
    // $stateProvider
    //   .state('posts', {
    //     url: '/posts/{id}',
    //     templateUrl: "angular/flapper_news/posts/_posts.html",
    //     controller: "PostsController",
    //     resolve: {
    //       post: ['$stateParams', 'posts', function($stateParams, posts) {
    //         var postID = $stateParams.id;
    //         return posts.findPostByID(postID);
    //       }]
    //     }
    //   })


		// default fall back route
		$urlRouterProvider.otherwise('/');


  });

})();



