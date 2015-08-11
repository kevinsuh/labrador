(function(){
	
	angular.module('flapper-news').factory('posts', ['$http', function($http) {
		// this array will persist throughout application
		// pre-populated with some fake info -- easy to take out later
		var o = {
			posts: []
		};

    o.getAll = function() {
      return $http.get('/posts.json').success(function(data) {
        angular.copy(data, o.posts);
      });
    };

    // post must be an object with the right post properties
    o.createPost = function(post) {
      return $http.post('/posts.json', post)
      .success(function(data) {
        o.posts.push(data);
      });
    };

    o.upvotePost = function(post) {
      return $http.put('/posts/'+post.id+'/upvote.json').success(function(data){
        post.already_upvoted = true
        post.upvotes++;
      });
    };

    o.findPostByID = function(postID) {
      return $http.get('/posts/'+postID+'.json').then(function(response) {
        return response.data;
      });
    }

    // add comment to specific post
    o.addComment = function(post, comment) {
      var postString = '/posts/' + post.id + '/comments.json';
      return $http.post(postString, comment);
    };

    o.upvoteComment = function(post, comment) {
      var putString = '/posts/' + post.id + '/comments/' + comment.id + '/upvote.json';
      return $http.put(putString);
    };

		return o;
	}]);

})();

