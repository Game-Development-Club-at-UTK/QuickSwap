shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
//use SCREEN_PIXEL_SIZE

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.

	if (texture(screen_texture, UV + vec2(0.0, SCREEN_PIXEL_SIZE.y)).x > .5) {
		COLOR.xyz = vec3(1.0,0.,0.);
	}
	if (texture(screen_texture, UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y)).x > .5) {
		COLOR.xyz = vec3(1.0,0.,0.);
	}
	if (texture(screen_texture, UV + vec2(SCREEN_PIXEL_SIZE.x, 0.0)).x > .5) {
		COLOR.xyz = vec3(1.0,0.,0.);
	}
	if (texture(screen_texture, UV + vec2(-SCREEN_PIXEL_SIZE.x, 0.0)).x > .5) {
		COLOR.xyz = vec3(1.0,0.,0.);
	}

}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
