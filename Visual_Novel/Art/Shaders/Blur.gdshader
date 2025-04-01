shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
void fragment() {
	// Called for every pixel the material is visible on.
	vec4 screen_sample = texture(SCREEN_TEXTURE, SCREEN_UV, 2.0);
	COLOR = screen_sample;
}