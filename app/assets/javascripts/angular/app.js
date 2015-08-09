// hook up our angular framework
(function(){
	
	var app = angular.module("TestApplication", ["TestDependentApplication"])

	app.controller('TestController', function(){
		this.test = "HELLO WORLD";
		this.cards = cards;
		this.testFunction = function(value) {
			if (value == 'HELLO WORLD') {
				this.test = "GOOD BYE WORLD..."
			} else {
				this.test = "HELLO WORLD";
			}
		};
	});

	var cards = [
		{ theme: "Birthday",
			price: 5,
			title: "Happy birthday!"
		},
		{ theme: "Father's Day",
			price: 7,
			title: "Happy father's day!"
		},
		{
			theme: "Mother's Day",
			price: 6.50,
			title: "I love you mommy."
		}
	];

})();

// current method to integrate angular with turbolinks
$(document).on('ready page:load', function() {
	angular.bootstrap(document.body, ['TestApplication']);
});
