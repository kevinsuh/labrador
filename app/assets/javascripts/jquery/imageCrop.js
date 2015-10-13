$(document).on('ready page:load', function() {

	$('#cropbox').Jcrop({
		aspectRatio: 0.75,
		setSelect: [0, 0, 150, 200],
		onSelect: update,
		onChange: update
	});

});

function update(coords) {
	$('#card_image_crop_x').val(coords.x);
	$('#card_image_crop_y').val(coords.y);
	$('#card_image_crop_w').val(coords.w);
	$('#card_image_crop_h').val(coords.h);
	updatePreview(coords);
}

function updatePreview(coords) {
	 $('#preview').css({
	 		width: Math.round(300/coords.w * $('#cropbox').width()) + 'px',
      height: Math.round(400/coords.h * $('#cropbox').height()) + 'px',
      marginLeft: '-' + Math.round(300/coords.w * coords.x) + 'px',
      marginTop: '-' + Math.round(400/coords.h * coords.y) + 'px'
	 });
}