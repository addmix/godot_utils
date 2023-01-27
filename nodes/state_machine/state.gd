extends Node
class_name State

signal change_state

#virtual
func _process(delta : float) -> void:
	pass
#virtual
func _physics_process(delta: float) -> void:
	pass
#virtual
func _enter(from : StringName) -> void:
	pass
#virtual
func _exit(to : StringName) -> void:
	pass
#virtual
func _unhandled_input(event: InputEvent) -> void:
	pass
