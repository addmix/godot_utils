extends Node

var floating_origin : FloatingOrigin

func get_global_position(node : Node) -> Vector3:
	return node.global_position + floating_origin.global_offset
