shader_type spatial;

uniform vec3 water_colour : source_color;
uniform sampler2D wave_noise;
varying vec2 local_UV;

void vertex() {
	local_UV = VERTEX.xz;
}

void fragment() {
	if (-100.0 < local_UV.x && local_UV.x < 100.0 && -100.0 < local_UV.y && local_UV.y < 100.0) {
		discard;
	}
	
	vec2 uv = UV * 3.5;
	
	// Water texture
	NORMAL_MAP = texture(wave_noise, (uv * 3.5)).rgb;
	NORMAL *= 0.5;
	ALBEDO = water_colour;
	ROUGHNESS = 0.2;
	ALPHA = 0.5;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
