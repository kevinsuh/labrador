(function() {

  var app = angular.module('flapper-news', ['ngAnimate', 'ui.router', 'templates', 'post-service']);

  app.config(function($stateProvider, $urlRouterProvider) {

    // home page that shows lists of posts and allows you to post new ones
  	$stateProvider
			.state('home', {
        url: '/home',
				templateUrl: "angular/home/home.html",
				controller: 'MainController'
			});

    // access a speciifc post so that we can see comments and other data surrounding it
    $stateProvider
      .state('posts', {
        url: '/posts/{id}',
        templateUrl: "angular/posts/posts.html",
        controller: "PostsController"
      })
		// default fall back route
		$urlRouterProvider.otherwise('home');
  });

  // we are passing in posts factory, which was added to this module as a dependency
  app.controller("PostsController", ['$scope', '$stateParams', 'posts', function($scope, $stateParams, posts) {

    $scope.newComment = "";

    // this is the post from the params
    $scope.post = posts.posts[$stateParams.id];
    $scope.comments = $scope.post.comments;

    // add comment functionality
    $scope.addComment = function() {

      newComment = {
        author: "anom",
        body: $scope.newComment,
        upvotes: 0
      }

      if ($scope.post.comments) {
        $scope.post.comments.push(newComment);
      } else {
        $scope.post.comments = [newComment];
      }
      
      $scope.newComment = "";
    };

  }]);

  app.controller('MainController', ['$scope', 'posts', function($scope, posts) {

    $scope.username = "kevin!";
    $scope.newPostTitle = "";
    $scope.newPostLink = "";
    $scope.posts = posts.posts;
    
    $scope.addPost = function() {
      newPost = {
        title: $scope.newPostTitle,
        link: $scope.newPostLink,
        upvotes: 0
      }
      $scope.posts.push(newPost);
      // reset the post title
      $scope.newPostTitle = "";
      $scope.newPostLink = "";
    };
    
    $scope.upvote = function(post) {
      post.upvotes++;
    }
      
  }]);
})();



