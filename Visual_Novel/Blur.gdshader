shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_sample = texture(SCREEN_TEXTURE, SCREEN_UV, 2.0);
	COLOR = screen_sample;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
