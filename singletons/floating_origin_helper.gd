@tool
extends Node

var floating_origin : FloatingOrigin

func get_global_position(node : Node3D) -> Vector3:
	if floating_origin:
		return node.global_position + floating_origin.global_offset
	else:
		return node.global_position

func adjust_global_position(global_position : Vector3) -> Vector3: 
	if floating_origin:
		return global_position + floating_origin.global_offset
	else:
		return global_position

func get_altitude(node : Node3D) -> float:
	return get_global_position(node).y
