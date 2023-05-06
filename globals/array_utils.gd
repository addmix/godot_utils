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
