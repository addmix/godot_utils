class_name NodeUtils

## Connects a signal in a safe way. Warnings and errors can be silenced, but the signal connection error is returned (The same as [code]Object.connect()[/code])
static func connect_signal_safe(node : Node, _signal : StringName, callable : Callable, flags : int = 0, silence_warning : bool = false) -> int:
	if not node.has_signal(_signal):
		if not silence_warning:
			push_warning("Signal does not exist on object")
		return ERR_DOES_NOT_EXIST
	elif node.is_connected(_signal, callable):
		if not silence_warning:
			push_warning("Signal already connected")
		return ERR_INVALID_PARAMETER
	
	return node.connect(_signal, callable, flags)

## Returns a node array containing all descendant nodes (Children, grandchildren, etc)
static func get_descendants(node : Node, include_internal : bool = false) -> Array[Node]:
	var children : Array[Node] = node.get_children(include_internal)

	#array for storing all descendants
	var arr : Array[Node] = []

	for i in range(children.size()):
		arr.append(children[i])
		#add child's array contents to self's array
		arr += get_descendants(children[i])

	return arr

## Returns the first child node of a given node type.
static func get_first_child_of_type(node : Node, type) -> Node:
	for child in node.get_children():
		if is_instance_of(child, type):
			return child
	return null

## Returns the first descendant of a given node type.
static func get_first_descandant_of_type(node : Node, type, include_internal : bool = false) -> Node:
	if is_instance_of(node, type):
		return node
	
	for child in node.get_children(include_internal):
		#returns node or null
		var descendant : Node = get_first_descandant_of_type(child, type, include_internal)
		#if not null, we have found a match
		if descendant:
			return descendant
	
	return null

## Returns a node array containing all descendants of a given node type.
static func get_descendants_of_type(node : Node, type, include_internal : bool = false) -> Array[Node]:
	var descandants_of_type : Array[Node] = []
	for child in node.get_children(include_internal):
		if is_instance_of(child, type):
			descandants_of_type.append(child)
		descandants_of_type = descandants_of_type + get_descendants_of_type(child, type)
	return descandants_of_type

## Checks if a child node of the given type exists.
static func has_node_of_type(node : Node, type) -> bool:
	for child in node.get_children():
		if is_instance_of(child, type):
			return true
	return false


## Returns the first ancestor node of the given type.
static func get_first_parent_of_type(node : Node, type) -> Node:
	var parent := node.get_parent()
	if parent == null:
		return null
	elif is_instance_of(parent, type):
		return parent
	else:
		return get_first_parent_of_type(parent, type)

## Returns the first ancestor node with the given name.
static func get_first_parent_with_name(node : Node, name : String) -> Node:
	var parent := node.get_parent()
	if parent == null:
		return null
	elif parent.name == name:
		return parent
	else:
		return get_first_parent_with_name(parent, name)
