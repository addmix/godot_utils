extends Node
class_name State

signal _change_state

func change_state(new_state : StringName) -> void:
	#this might be bad
	if not is_multiplayer_authority():
		return
	
	_change_state.emit.call_deferred(new_state, self)

#virtual 
func _ready() -> void:
	pass
#virtual
func _process(delta : float) -> void:
	pass
#virtual
func _physics_process(delta : float) -> void:
	pass
#virtual
func _unhandled_input(event : InputEvent) -> void:
	pass
#virtual
func _enter(from : StringName) -> void:
	pass
#virtual
func _exit(to : StringName) -> void:
	pass
