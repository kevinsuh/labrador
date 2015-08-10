(function() {

  var app = angular.module('flapper-news', ['ngAnimate', 'ui.router', 'templates']);

  app.config(function($stateProvider, $urlRouterProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/home',
				templateUrl: "angular/flapper_news/home/_home.html",
				controller: 'MainController',
        resolve: {
          postPromise: ['posts', function(posts) {
            return posts.getAll();
          }]
        }
			});

        
    // access a speciifc post so that we can see comments and other data surrounding it
    $stateProvider
      .state('posts', {
        url: '/posts/{id}',
        templateUrl: "angular/flapper_news/posts/_posts.html",
        controller: "PostsController",
        resolve: {
          post: ['$stateParams', 'posts', function($stateParams, posts) {
            var postID = $stateParams.id;
            return posts.findPostByID(postID);
          }]
        }
      })
		// default fall back route
		$urlRouterProvider.otherwise('home');
  });

})();



