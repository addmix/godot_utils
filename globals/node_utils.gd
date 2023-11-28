class_name NodeUtils

static func get_descendants(node : Node, include_internal : bool = false) -> Array[Node]:
	var children : Array[Node] = node.get_children(include_internal)

	#array for storing all descendants
	var arr := []

	for i in range(children.size()):
		arr.append(children[i])
		#add child's array contents to self's array
		arr += get_descendants(children[i])

	return arr

static func get_first_parent_which_is_a(node : Node, type) -> Node:
	var parent := node.get_parent()
	if parent == null:
		return null
	elif is_instance_of(parent, type):
		return parent
	else:
		return get_first_parent_which_is_a(parent, type)

static func get_first_parent_with_name(node : Node, _name : String) -> Node:
	var parent := node.get_parent()
	if parent == null:
		return null
	elif parent.name == _name:
		return parent
	else:
		return get_first_parent_with_name(parent, _name)

static func get_descendants_of_type(node : Node, type, include_internal : bool = false) -> Array[Node]:
	var descandants_of_type : Array[Node] = []
	for child in node.get_children(include_internal):
		if is_instance_of(child, type):
			descandants_of_type.append(child)
		descandants_of_type = descandants_of_type + get_descendants_of_type(child, type)
	return descandants_of_type

#returns signal connection error, if any. Mainly for plugin nodes
static func connect_signal_safe(node : Node, _signal : StringName, callable : Callable, flags : int = 0) -> int:
	if not node.has_signal(_signal):
		return node.connect(_signal, callable, flags)
	#mimick godot's default error for doubly connected signals
	push_warning("Signal already connected")
	return ERR_INVALID_PARAMETER


