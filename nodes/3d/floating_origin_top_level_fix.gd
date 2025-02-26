extends Node
class_name FloatingOriginTopLevelFix

## This fixes floating origin functionality for [code]Node3D[/code]s where [code]top_level[/code] is enabled.

func _enter_tree():
	if has_node("/root/FloatingOriginHelper"):
		NodeUtils.connect_signal_safe(get_node("/root/FloatingOriginHelper"), "origin_shifted", _on_origin_shifted, 0, true)

func _on_origin_shifted(shift : Vector3) -> void:
	if get_parent() is Node3D and get_parent().top_level:
		get_parent().global_position -= shift
