shader_type spatial;
//render_mode world_vertex_coords;

//where my stuff starts
//global uniform sampler2D backgroundTexture : source_color, filter_nearest;

varying vec3 pixelColor;
varying vec3 lineColor;
varying vec3 backgroundColor;

varying vec4 viewSpacePos;
varying vec4 clipSpacePos;
varying vec3 ndcSpacePos;
varying vec2 windowSpacePos;

//where their stuff starts
uniform bool enable_normal_map = false;
//uniform bool enable_roughness = false;
uniform float roughness = 1;

group_uniforms x_plane;
uniform sampler2D x_albedo: source_color, filter_nearest;
uniform sampler2D x_normal_map: hint_normal, filter_nearest;
uniform sampler2D x_roughness: hint_roughness_r;
uniform float x_scale = 1.0;

group_uniforms y_plane;
uniform sampler2D y_albedo: source_color, filter_nearest;
uniform sampler2D y_normal_map: hint_normal, filter_nearest;
uniform sampler2D y_roughness: hint_roughness_r;
uniform float y_scale = 1.0;

group_uniforms z_plane;
uniform sampler2D z_albedo: source_color, filter_nearest;
uniform sampler2D z_normal_map: hint_normal, filter_nearest;
uniform sampler2D z_roughness: hint_roughness_r;
uniform float z_scale = 1.0;

void vertex() {
	//2d point finder
	viewSpacePos = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	clipSpacePos = PROJECTION_MATRIX * viewSpacePos; //convert to clip space
	ndcSpacePos = clipSpacePos.xyz / clipSpacePos.w; //convert to device space(0 to 1)

	windowSpacePos.x = ((ndcSpacePos.x + 1.0) / 2.0);
	windowSpacePos.y = ((ndcSpacePos.y + 1.0) / 2.0);
	//windowSpacePos = windowSpacePos * VIEWPORT_SIZE; //scale to viewport
}

vec3 triplanar_map(vec3 x, vec3 y, vec3 z, vec3 n) {
	n = n*n;
    return (x*n.x + y*n.y + z*n.z)/(n.x+n.y+n.z);
}

vec3 triplanar_tritexture(sampler2D x_texture, sampler2D y_texture, sampler2D z_texture, vec3 d, vec3 n) {
    vec3 colx = texture(x_texture, d.zy * x_scale).xyz;
    vec3 coly = texture(y_texture, d.xz * y_scale).xyz;
    vec3 colz = texture(z_texture, d.xy * z_scale).xyz;
    return triplanar_map(colx, coly, colz, n);
}

void fragment() {
	vec3 world_vertex = (INV_VIEW_MATRIX * vec4(VERTEX, 1.)).xyz;
	vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.)).xyz;
	if (enable_normal_map) {
		BINORMAL = triplanar_map(
			normalize((VIEW_MATRIX * vec4(0.,-1.,0.,0)).xyz),
			normalize((VIEW_MATRIX * vec4(0.,0.,1.,0)).xyz),
			normalize((VIEW_MATRIX * vec4(0,-1.,0.,0)).xyz),
			world_normal
		);

		TANGENT = triplanar_map(
			normalize((VIEW_MATRIX * vec4(0.,1.,0.,-1.)).xyz),
			normalize((VIEW_MATRIX * vec4(1.,0.,0.,1.)).xyz),
			normalize((VIEW_MATRIX * vec4(0,0.,1.,-1.)).xyz),
			world_normal
		);
		NORMAL_MAP = triplanar_tritexture(x_normal_map, y_normal_map, z_normal_map, world_vertex, world_normal);
	}

	pixelColor = triplanar_tritexture(x_albedo, y_albedo, z_albedo, world_vertex, world_normal);
//	ALBEDO = pixelColor;
	if (pixelColor == vec3(1.,1.,1.)) {
		lineColor = vec3(sin(TIME / 5.0),sin(TIME / 7.0),cos(TIME / 5.0));
		ALBEDO = lineColor;
	}
	else {
		//backgroundColor = texture(backgroundTexture, SCREEN_UV).xyz;
		//ALBEDO = backgroundColor;
		ALBEDO = pixelColor;
	}

//	if (enable_roughness) {
//		ROUGHNESS = triplanar_tritexture(x_roughness, y_roughness, z_roughness, world_vertex, world_normal).r;
//	} else {
//		ROUGHNESS = roughness;
//	}

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
