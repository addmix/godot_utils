@tool
extends Node

signal pre_origin_shift(shift : Vector3)
signal origin_shifted(shift : Vector3)

var floating_origin : FloatingOrigin:
	set(x):
		if is_instance_valid(floating_origin):
			floating_origin.pre_origin_shift.disconnect(_on_floating_origin_pre_origin_shift)
			floating_origin.origin_shifted.disconnect(_on_floating_origin_origin_shifted)
		floating_origin = x
		floating_origin.pre_origin_shift.connect(_on_floating_origin_pre_origin_shift)
		floating_origin.origin_shifted.connect(_on_floating_origin_origin_shifted)

func get_global_position(node : Node3D) -> Vector3:
	if is_instance_valid(floating_origin):
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

func _on_floating_origin_pre_origin_shift(shift : Vector3) -> void:
	pre_origin_shift.emit(shift)
func _on_floating_origin_origin_shifted(shift : Vector3) -> void:
	origin_shifted.emit(shift)
