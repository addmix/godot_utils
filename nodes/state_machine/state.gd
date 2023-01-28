extends Node
class_name State

signal _change_state

func change_state(new_state : StringName) -> void:
	call_deferred("emit_signal", "_change_state", new_state)

#virtual
func _process(delta : float) -> void:
	pass
#virtual
func _physics_process(delta : float) -> void:
	pass
#virtual
func _enter(from : StringName) -> void:
	pass
#virtual
func _exit(to : StringName) -> void:
	pass
#virtual
func _unhandled_input(event : InputEvent) -> void:
	pass
