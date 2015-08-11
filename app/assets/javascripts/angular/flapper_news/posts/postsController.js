(function() {
  angular.module('flapper-news').controller("PostsController", ['$scope', 'posts', 'post', function($scope, posts, post) {

  $scope.newComment = "";

  // get post from state resolve
  $scope.post = post;
  $scope.comments = $scope.post.comments;
  console.log($scope.comments);

  // add comment functionality
  $scope.addComment = function() {

    posts.addComment(post, {
      body: $scope.newComment
    })
    .success(function(comment) {

      var commentCollection = {
        comment: comment,
        already_upvoted: false
      }

      $scope.post.comments.push(commentCollection);
    })
    .error(function(data) {
      $scope.success = data.success;
      $scope.message = data.message;
    });
    
    $scope.newComment = "";
  };

  // upvote comment -- we handle this via collection since it is PART OF POST
  $scope.upvote = function(commentCollection) {
    var comment = commentCollection["comment"]
    posts.upvoteComment(post, comment)
    .success(function(data){
      commentCollection.already_upvoted = true
      comment.upvotes++;
    })
    .error(function(data) {
      $scope.success = data.success;
      $scope.message = data.message;
    }); 
  }

}]);
})();
