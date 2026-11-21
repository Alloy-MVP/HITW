shader_type canvas_item;

uniform float amplification : hint_range(0.01, 0.05);
uniform sampler2D camera_output : hint_screen_texture;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 initial_uv = uv;
	
	uv.x += sin(TIME*1.5 + initial_uv.y * 15.0) * amplification;
	uv.y += cos(TIME*2.0 + initial_uv.x * 10.0) * amplification;
	
	COLOR = texture(camera_output, uv);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
