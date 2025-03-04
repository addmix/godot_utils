shader_type spatial;
render_mode blend_add, unshaded, specular_schlick_ggx;

uniform sampler2D _texture_albedo : source_color;
uniform float _distance = 1.0;
uniform float _scale = 0.1;

//should implement some hue shift or something here
uniform float _intensity_factor = 1.0;
uniform float _alpha = 1.0;

void vertex() {
	VERTEX = VERTEX * _scale * _distance;
	VERTEX = VERTEX + (vec3(0.0, 0.0, -_distance));

}

void fragment() {
	//vec2 pixelPositionClipSpace = (SCREEN_UV - 0.5) * 2.0; // in clip space top left is (-1,-1) and bottom right is (1,1)
	//vec3 normalViewSpaceNormalized = NORMAL / NORMAL.z; // normal is by default in view space; divide by z so we have z=1
	//float ratio = VIEWPORT_SIZE.x / VIEWPORT_SIZE.y; // screen ratio
	//float slope = -1.0 / PROJECTION_MATRIX[1][1]; // in 1m distance from the camera, how high is the top pixel row above the camera?
//
	//// without multiplying by 'vec2(ratio,1.0)' the width of the reticle would be wrong and dependent on screen width
	//vec2 UV_new = ((pixelPositionClipSpace + vec2(normalViewSpaceNormalized.x / (ratio * slope), -normalViewSpaceNormalized.y / slope)) / _scale) * vec2(ratio,1.0) + vec2(0.5,0.5);

	//if(max(abs(UV_new.x-0.5), abs(UV_new.y-0.5)) > 0.5){
		//discard; // or set a color, whatever
	//}

	//UV_new = clamp(UV_new, vec2(0,0), vec2(1,1));
	DEPTH = 1.0;
	//vec4 col = texture(_texture_albedo, UV_new);
	vec4 col = texture(_texture_albedo, UV);
	ALBEDO = col.rgb;// * reticle_color.rgb;
	ALPHA = col.a;// * reticle_color.a;
}