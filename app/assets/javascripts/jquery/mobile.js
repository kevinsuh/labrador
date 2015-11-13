// mobile specific helper functions
$(document).on('ready page:load', function() {	

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

   content.height(contentheight);
}

// this is specific for the recipient modal form
// and adds scroll to the address / occaision part of the form
function ScaleContentToDeviceForRecipientForm() {

	scroll(0, 0);
 var headerHeight = 50;
 var footerHeight = $(".main_footer:visible").outerHeight();
 var viewportHeight = $(window).height();

 var modal_header = $(".modal-header:visible");
 var modal_header_height = modal_header.outerHeight();
 
 var content = $(".modal-body:visible");

 var contentMargins =  content.outerHeight() - content.height();

 var contentheight = viewportHeight - headerHeight - footerHeight - modal_header_height - contentMargins;

 content.height(contentheight);

}
