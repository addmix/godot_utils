class_name NodeUtils

static func get_child_recursive(obj : Node) -> Array:
	var children : Array = obj.get_children()

	#array for storing all descendants
	var arr := []

	for i in range(children.size()):
		arr.append(children[i])
		#add child's array contents to self's array
		arr += get_child_recursive(children[i])

	return arr

#recursive function
static func get_first_parent_which_is_a(obj : Node, type) -> Node:
	var parent := obj.get_parent()
	if parent == null:
		return null
	elif parent is type:
		return parent
	else:
		return get_first_parent_which_is_a(parent, type)
