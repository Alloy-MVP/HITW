shader_type spatial;

uniform vec3 water_colour : source_color;
uniform sampler2D wave_noise;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	// Wave animation
	vec2 uv = UV * 35.0;
	uv.x += sin((TIME/2.0) + (uv.x + uv.y) * 25.0) * 0.01;
	uv.y += cos((TIME*1.5) + (uv.x - uv.y) * 25.0) * 0.01;
	
	// Water texture
	NORMAL_MAP = texture(wave_noise, uv).rgb;
	NORMAL *= 0.5;
	ALBEDO = water_colour;
	ROUGHNESS = 0.2;
	ALPHA = 0.5;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
