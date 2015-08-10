(function(){

	
	angular.module('flapper-news').factory('posts', function() {
		// this array will persist throughout application
		// pre-populated with some fake info -- easy to take out later
		var o = {
			posts: [
      { title: 'this is an nba link!',
      	link: "http://www.realgm.com",
        upvotes: 8
      },
      { title: 'the best search engine',
        upvotes: 5,
        link: "http://www.google.com"
      },
      { title: 'just a random post',
        upvotes: 7
      },
      { title: 'another test post',
        upvotes: 2
      },
      { title: 'just ignore me now... this is a test post',
        upvotes: 4
      },
      {
	      title: "cardagain rules!",
	      link: "https://dev-cardagain.herokuapp.com/",
	      upvotes: 0,
	      comments: [
	        {author: 'Kevin', body: "cool post bro", upvotes: 0},
	        {author: "Chip", body: "yeah cool post man!", upvotes: 0},
	        {author: "Emily", body: "not that cool of a post dude...", upvotes: 0}
	      ]
	    }
      ]
		};
		return o;
	});

})();