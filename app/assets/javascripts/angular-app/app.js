(function() {

  var app = angular.module('flapper-news', ['ngAnimate', 'ui.router', 'templates', 'post-service']);

  app.config(function($stateProvider, $urlRouterProvider) {

  	$stateProvider
			.state('home', {
        url: '/home',
        // template: "<h1>hello austin</h1>",
				templateUrl: "angular/home/home.html",
				controller: 'MainController'
			});

			// default fall back route
			$urlRouterProvider.otherwise('/');
  });
  
  app.controller('MainController', ['$scope', 'posts', function($scope, posts) {
  	$scope.things = ['Angular', 'Rails', 'UI Router', 'Together!!']
    $scope.username = "kevin!";
    $scope.newPostTitle = "";
    $scope.newPostLink = "";
    $scope.posts = posts.posts;
   
    $scope.sayHello = function() {
      $scope.greeting = "Whaddup " + $scope.username; 
    };
    
    $scope.hideHello = function() {
      $scope.greeting = "";
    };
    
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
    
    $scope.upvotePost = function(post) {
      post.upvotes++;
    }
      
    $scope.posts = [
      { title: 'post 1',
        upvotes: 8
      },
      { title: 'post 2',
        upvotes: 5,
        link: "http://www.realgm.com"
      },
      { title: 'post 3',
        upvotes: 7
      },
      { title: 'post 4',
        upvotes: 2
      },
      { title: 'post 5',
        upvotes: 4
      }
      ]
    
  }]);
})();



