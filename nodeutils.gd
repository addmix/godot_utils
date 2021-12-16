extends Node

func get_child_recursive(obj : Node) -> Array:
	var children : Array = obj.get_children()
	
	#array for storing all descendants
	var arr := []
	
	for i in range(children.size()):
		arr.append(children[i])
		#add child's array contents to self's array
		arr += get_child_recursive(children[i])
	
	return arr
