// mobile specific helper functions
$(document).on('ready page:load', function() {	

	ScaleContentToDevice();

	 if ('ontouchstart' in window) {
	    /* cache dom references */ 
	    var $body = $('body'); 

	    /* bind events */
	    $(document)
	    .on('focus', 'input', function() {
	        $body.addClass('fixfixed');
	    })
	    .on('blur', 'input', function() {
	        $body.removeClass('fixfixed');
	    });
			
	}

});

$(document).on("pageshow", function(){
   ScaleContentToDevice();
});
$(window).on('resize orientationchange', function(){ ScaleContentToDevice() });

function ScaleContentToDevice() {
   scroll(0, 0);
   //var headerHeight = $(".main_header:visible").outerHeight();
   var headerHeight = 50;
   var footerHeight = $(".main_footer:visible").outerHeight();

   var viewportHeight = $(window).height();

   var content = $(".page_container:visible");
   var contentMargins =  content.outerHeight() - content.height();

   var contentheight = viewportHeight - headerHeight - footerHeight - contentMargins;

   console.log("creating content height");
   console.log(contentheight);
   console.log(content);
   // $(".page_container").height(58);
   content.height(contentheight);
}