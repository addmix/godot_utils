//Copyright 2025 Addmix
//
//Permission is hereby granted, free of charge, to any person obtaining a copy 
//of this software and associated documentation files (the “Software”), to deal 
//in the Software without restriction, including without limitation the rights 
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//copies of the Software, and to permit persons to whom the Software is 
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in 
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
//THE SOFTWARE.
//
//
//
// This is a collimator/projection/red dot/holographic/HUD shader
// Usage examples include: red dot sights on guns, HUDs in aircraft
// VR-compatible, and designed to work in double-precision builds



shader_type spatial;
render_mode blend_add, unshaded, specular_schlick_ggx;

uniform sampler2D _texture_albedo : source_color;
uniform float _scale = 0.1;

//should implement some hue shift or something here
uniform float _intensity_factor = 1.0;
uniform float _alpha = 1.0;

void fragment() {
	mat3 model_rotation = mat3(MODEL_MATRIX[0].xyz, MODEL_MATRIX[1].xyz, MODEL_MATRIX[2].xyz);
	mat3 view_rotation = mat3(VIEW_MATRIX[0].xyz, VIEW_MATRIX[1].xyz, VIEW_MATRIX[2].xyz);
	mat3 modelview_rotation = view_rotation * model_rotation;
	
	//this is the normal of the projected sight
	vec3 n = modelview_rotation * vec3(0.0, 0.0, -1.0);
	//tangent vectors for UV directions
	vec3 u_dir = modelview_rotation * vec3(1.0, 0.0, 0.0);
	vec3 v_dir = modelview_rotation * vec3(0.0, 1.0, 0.0);
	
	//vertex position in view space
	vec3 vert = VIEW;//object_to_view(MODELVIEW_MATRIX, VERTEX);
	float a = 1.0 / dot(vert, n);
	vec3 vert_prime = a * vert;
	
	vec2 uv = vec2(-dot(vert_prime, u_dir), dot(vert_prime, v_dir));
	uv = uv / -_scale;
	uv += vec2(0.5, 0.5);
	
	vec4 color = texture(_texture_albedo, uv);
	
	if(uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0){
		color.a = 0.0;
	}
	ALBEDO = color.rgb;
	ALPHA = color.a;
}
