shader_type spatial;
render_mode unshaded, depth_test_disabled;

uniform float _length = 0.0;
uniform float _width = 1.0;
uniform vec3 _color = vec3(0, 0, 0);

void vertex() {
	VERTEX = VERTEX * _width;
	VERTEX -= float(VERTEX.z < 0.0) * vec3(0, 0, _length);
}

void fragment() {
	ALBEDO = _color;
}
