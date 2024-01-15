shader_type spatial;
render_mode blend_add, unshaded, specular_schlick_ggx;

uniform sampler2D _texture_albedo : source_color;
uniform float _distance = 1.0;
uniform float _scale = 0.1;

//should implement some hue shift or something here
uniform float _intensity_factor = 1.0;
uniform float _alpha = 1.0;

vec3 transform(mat4 matrix, vec3 pos){
	return (matrix * vec4(pos, 1.0)).xyz;
}
vec3 object_to_view(mat4 modelview_matrix, vec3 pos) {
	return transform(modelview_matrix, pos);
}

vec3 object_to_clip(mat4 modelview_matrix, mat4 projection_matrix, vec3 pos) {
	vec3 view_space = transform(modelview_matrix, pos);
	return transform(projection_matrix, view_space);
}

void vertex() {
	vec3 vertex = vec3(0.0);
	vec2 uv = vec2(0.0);


//from Mux
//So basically you would do: vec3 view_pos = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz + 
//EYE_OFFSET, and get a position that is properly adjusted for the eye being rendered. But 
//only after I add in support for accessing EYE_OFFSET


	vec3 lens_origin = object_to_view(MODELVIEW_MATRIX, vec3(0.0)) - EYE_OFFSET;
	
	//this is the centerpoint of the projected sight, offset from the model
	vec3 p0 = object_to_view(MODELVIEW_MATRIX, vec3(0.0, 0.0, -_distance)) - EYE_OFFSET;
	
	//this is the normal of the projected sight
	vec3 n = object_to_view(MODELVIEW_MATRIX, vec3(0.0, 0.0, -1.0)) - lens_origin - EYE_OFFSET;
	
	//tangent vector along the U direction (in UV)
	vec3 u_dir = object_to_view(MODELVIEW_MATRIX, vec3(1.0, 0.0, 0.0)) - lens_origin - EYE_OFFSET;
	
	//tangent vector along the V direction (in UV)
	vec3 v_dir = object_to_view(MODELVIEW_MATRIX, vec3(0.0, 1.0, 0.0)) - lens_origin - EYE_OFFSET;
	
	//vertex position
	vec3 vert = object_to_view(MODELVIEW_MATRIX, VERTEX) - EYE_OFFSET;
	float a = dot(p0, n) / dot(vert, n);
	vec3 vert_prime = a * vert;
	
	vertex = VERTEX;
	uv = vec2(-dot(vert_prime - p0, u_dir), dot(vert_prime - p0, v_dir));
	uv = uv / (_scale * -_distance);
	uv += vec2(0.5, 0.5);

	VERTEX = vertex;
	UV = uv;
}

void fragment() {
	vec4 color = texture(_texture_albedo, UV);

	//swap this for hue shift
	//fixed4 col = _Color;
	//col.a = tex.r;

	if(UV.x < 0.0 || UV.x > 1.0 || UV.y < 0.0 || UV.y > 1.0){
		color.a = 0.0;
	}
	ALBEDO = color.rgb;
	ALPHA = color.a;
}