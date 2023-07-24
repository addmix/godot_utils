class_name NodeUtils

static func get_descendants(obj : Node) -> Array:
	var children : Array = obj.get_children()

	#array for storing all descendants
	var arr := []

	for i in range(children.size()):
		arr.append(children[i])
		#add child's array contents to self's array
		arr += get_descendants(children[i])

	return arr

#recursive function
static func get_first_parent_which_is_a(obj : Node, type) -> Node:
	var parent := obj.get_parent()
	if parent == null:
		return null
	elif is_instance_of(parent, type):
		return parent
	else:
		return get_first_parent_which_is_a(parent, type)

static func get_first_parent_with_name(obj : Node, _name : String) -> Node:
	var parent := obj.get_parent()
	if parent == null:
		return null
	elif parent.name == _name:
		return parent
	else:
		return get_first_parent_with_name(parent, _name)
