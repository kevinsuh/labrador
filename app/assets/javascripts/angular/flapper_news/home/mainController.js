(function() {
	
	angular.module('flapper-news').controller('MainController', ['$scope', 'posts', function($scope, posts) {

		//console.log(postPromise);

	  $scope.username = "kevin!";
	  $scope.newPostTitle = "";
	  $scope.newPostLink = "";
	  $scope.posts = posts.posts;

	  console.log($scope.posts);

	  // the title is validated to be non-blank before this function gets called. link can be blank
	  $scope.addPost = function() {

	    posts.createPost({
	      title: $scope.newPostTitle,
	      link: $scope.newPostLink,
	      upvotes: 0
	    })
      .error(function(data) {
        $scope.success = data.success;
        $scope.message = data.message;
      });

	    // reset the post title
	    $scope.newPostTitle = "";
	    $scope.newPostLink = "";

	  };
	  
	  // upvote post
	  $scope.upvote = function(post) {
	  	posts.upvotePost(post)
	  	.error(function(data) {
	  		$scope.success = data.success;
	  		$scope.message = data.message;
	  	});
	  }
	    
	}]);

})();
