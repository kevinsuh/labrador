(function() {
  angular.module('flapper-news').controller("PostsController", ['$scope', '$stateParams', 'posts', function($scope, $stateParams, posts) {

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
})();
