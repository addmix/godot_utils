extends Node
class_name State

signal change_state

func _process(delta : float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _enter(from : StringName) -> void:
	pass

func _exit(to : StringName) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass
