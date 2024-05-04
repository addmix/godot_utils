@tool
extends Node

var floating_origin : FloatingOrigin

func get_global_position(node : Node3D) -> Vector3:
	if floating_origin:
		return node.global_position + floating_origin.global_offset
	else:
		return node.global_position

func get_global_transform(node : Node3D) -> Transform3D:
	if floating_origin:
		return node.global_transform * Transform3D(Basis(), floating_origin.global_offset)
	else:
		return node.global_transform

func adjust_global_position(global_position : Vector3) -> Vector3: 
	if floating_origin:
		return global_position + floating_origin.global_offset
	else:
		return global_position

func get_altitude(node : Node3D) -> float:
	return get_global_position(node).y
