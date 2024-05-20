extends Node

func _init():
	FloatingOriginHelper.origin_shifted.connect(_on_origin_shifted)

func _on_origin_shifted(shift : Vector3) -> void:
	if get_parent() is Node3D and get_parent().top_level:
		get_parent().global_position -= shift
