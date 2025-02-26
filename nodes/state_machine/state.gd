extends Node
class_name State

## Internal signal, used to notify the StateMachine when this state is trying to transition to another state.
signal _change_state

## This function propagates a state change to the StateMachine.
@rpc("authority", "call_local", "reliable")
func change_state(new_state : StringName) -> void:
	_change_state.emit.call_deferred(new_state, self)

## These functions are allowed to be overridden by scripts that extend the State class.

## Virtual function for use in scripts that extend this class.
func _ready() -> void:
	pass
## Virtual function for use in scripts that extend this class.
func _process(delta : float) -> void:
	pass
## Virtual function for use in scripts that extend this class.
func _physics_process(delta : float) -> void:
	pass
## Virtual function for use in scripts that extend this class.
func _unhandled_input(event : InputEvent) -> void:
	pass
## Virtual function for use in scripts that extend this class.
func _enter(from : StringName) -> void:
	pass
## Virtual function for use in scripts that extend this class.
func _exit(to : StringName) -> void:
	pass
