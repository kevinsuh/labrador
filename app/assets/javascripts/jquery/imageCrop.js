$(document).on('ready page:load', function() {

	$('#cropbox').Jcrop({
		aspectRatio: 0.625,
		setSelect: [0, 0, 125, 200],
		onSelect: update,
		onChange: update
	});

});

function update(coords) {
	$('#card_image_crop_x').val(coords.x);
	$('#card_image_crop_y').val(coords.y);
	$('#card_image_crop_w').val(coords.w);
	$('#card_image_crop_h').val(coords.h);
}