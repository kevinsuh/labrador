(function() {
	
	angular.module('flapper-news').controller('MainController', ['$scope', 'posts', function($scope, posts) {

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
