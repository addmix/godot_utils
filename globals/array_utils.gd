class_name ArrayUtils

static func intersect(arr1 : Array, arr2 : Array) -> Array:
	var _intersect : Array = []
	for a in arr2:
		if arr1.has(a):
			_intersect.append(a)
	return _intersect

static func difference(arr1 : Array, arr2 : Array) -> Array:
	var _difference : Array = []
	for i in arr1:
		if !arr2.has(i):
			_difference.append(i)
	return _difference

static func is_array(arr) -> bool:
	return typeof(arr) in [
		TYPE_ARRAY,
		TYPE_PACKED_BYTE_ARRAY,
		TYPE_PACKED_COLOR_ARRAY,
		TYPE_PACKED_INT32_ARRAY,
		TYPE_PACKED_INT64_ARRAY,
		TYPE_PACKED_FLOAT32_ARRAY,
		TYPE_PACKED_FLOAT64_ARRAY,
		TYPE_PACKED_STRING_ARRAY,
		TYPE_PACKED_VECTOR2_ARRAY,
		TYPE_PACKED_VECTOR3_ARRAY,
		TYPE_PACKED_COLOR_ARRAY,
		TYPE_PACKED_VECTOR4_ARRAY,
	]
	
