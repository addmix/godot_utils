class_name ArrayUtils

static func intersect(arr1 : Array, arr2 : Array) -> Array:
	var _intersect : Array = []
	for a in arr2:
		if arr1.has(a):
			_intersect.append(a)
	return _intersect

static func difference(arr1 : Array, arr2 : Array) -> Array:
	var _difference : Array = arr1.duplicate()
	for i in arr2:
		_difference.erase(i)
	return _difference
