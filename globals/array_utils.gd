class_name ArrayUtils

## Helpful utilities for working with Arrays. 

## Returns an array of random integers with length [code]amount[/code]. Minimum and maximum values can be specified.
static func get_random_ints(amount : int, min : int = 0, max : int = 9) -> PackedInt64Array:
	var array := PackedInt64Array([])

	for i in range(amount):
		array.append(randi_range(min, max) % 10)

	return array

## Takes an array [code]input[/code] and returns an array with all instances of [code]exclude[/code] removed.
static func exclude_by_value(input : Array, exclude : Variant) -> Array:
	var selection := []

	for i in range(input.size()):
		if input[i] != exclude:
			selection.append(input[i])

	return selection

## Takes two arrays, and returns an array containing all values that are common between both arrays.
static func intersect(arr1 : Array, arr2 : Array) -> Array:
	var _intersect : Array = []
	for a in arr2:
		if arr1.has(a):
			_intersect.append(a)
	return _intersect

## Returns an array filled with all items from [code]arr1[/code] which are not contained in [code]arr2[/code][br]
## Subtracts [code]arr2[/code] from [code]arr1[/code][br]
## NOTE: difference(arr1, arr2) may not be the same as difference(arr2, arr1)
static func difference(arr1 : Array, arr2 : Array) -> Array:
	var _difference : Array = []
	for i in arr1:
		if !arr2.has(i):
			_difference.append(i)
	return _difference

## Checks if [code]arr[/code] is any type of array or packed array.
static func is_array(arr : Variant) -> bool:
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
	
