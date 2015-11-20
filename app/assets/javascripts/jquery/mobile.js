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
$(window).on('resize orientationchange', function(){ 
	ScaleContentToDevice() });

function ScaleContentToDevice() {
   scroll(0, 0);
   //var headerHeight = $(".main_header:visible").outerHeight();
   var headerHeight = 50;
   // //var footerHeight = $(".main_footer:visible").outerHeight();
   // var footerHeight = 80;

   // // disregard footer height if crop image footer is here -- this is a big hack for now.
   // console.log($(".cropImage").length);
   // if ($(".cropImage").length > 0) {
   // 	console.log("hey crop image footers visible/..!")
   // 	footerHeight = 0;
   // }

   footerHeight = 0;

   var viewportHeight = $(window).height();

   var content = $(".page_container:visible");
   var contentMargins =  content.outerHeight() - content.height();

   var contentheight = viewportHeight - headerHeight - footerHeight - contentMargins;

   content.height(contentheight);

   // queue wizard container doesn't include footer
   var content = $(".queue_wizard_container:visible");
   var height = content.height() - 84;
   content.height(height);
}


// this is specific for the recipient modal form
// and adds scroll to the address / occaision part of the form
function ScaleContentToDeviceForRecipientForm() {

	scroll(0, 0);
 var headerHeight = 50;
 //var footerHeight = $(".main_footer:visible").outerHeight();
 var footerHeight = 80;
 var viewportHeight = $(window).height();

 var content = $(".page_container:visible");
 var contentMargins =  content.outerHeight() - content.height();

 var contentheight = viewportHeight - headerHeight - footerHeight - contentMargins;

 var modal_header = $(".modal-header:visible");
 var modal_header_height = modal_header.outerHeight();

 var modalBody = $(".modal-body:visible");
 var modalBodyMargins =  modalBody.outerHeight() - modalBody.height();

 var modalBodyHeight = contentheight - modal_header_height - footerHeight;

 modalBody.height(modalBodyHeight);

}
