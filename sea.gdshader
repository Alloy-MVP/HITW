shader_type spatial;
render_mode blend_mix;

uniform vec3 water_colour : source_color;
uniform sampler2D wave_noise;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	// Wave animation
	vec2 uv1 = UV * 4.0;
	vec2 uv2 = UV * 35.0;
	uv1.x += 2.0*sin((TIME/2.0) + (uv1.x + uv1.y) * 25.0) * 0.01;
	uv1.y += 2.0*cos((TIME/3.0) + (uv1.x - uv1.y) * 25.0) * 0.01;
	vec3 uv1_normal = texture(wave_noise, uv1).rgb;
	vec3 uv2_normal = texture(wave_noise, uv2).rgb;
	
	// Water texture
	NORMAL_MAP = mix(uv1_normal, uv2_normal, 0.5);
	NORMAL *= 0.5;
	ALBEDO = water_colour;
	ROUGHNESS = 0.2;
	ALPHA = 0.4;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
