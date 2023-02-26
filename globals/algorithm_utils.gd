class_name AlgorithmUtils

static func get_random_ints(amount : int) -> Array:
	var array := []

# warning-ignore:unused_variable
	for i in range(amount):
		array.append(randi() % 10)

	return array

static func exclude_by_value(input : Array, exculde) -> Array:
	var selection := []

	# warning-ignore:unused_variable
	for i in range(input.size()):
		if input[i] != exculde:
			selection.append(input[i])

	return selection
