extends Node
class_name StateMachine

## A base-class for a finite state machine (FSM). Typically, this will be extended, and the "StateMachine" node will act as the center of communication between the child states, and the rest of the scene.

## Internal list of references for all available states parented to this state machine.
var states := {}
## The starting state of the state machine.
@export var current_state := "":
	set(x):
		current_state = x
## Internal reference to the current state.
var state : State

func _ready() -> void:
	var children := get_children()
	for x in children:
		var child : State
		if !x is State:
			continue
		child = x
		states[child.name] = child
		child._change_state.connect(change_state)
		child.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	if not current_state:
		var first_state : State = NodeUtils.get_first_child_of_type(self, State)
		if not first_state:
			return
		current_state = first_state.name
	
	states[current_state].set_process_mode(Node.PROCESS_MODE_INHERIT)
	states[current_state]._enter("_init")

## Performs a state transition. First, calling the _exit() function on the current state and disabling processing on it, then calling _enter() on the new state, and enabling processing.
@rpc("authority", "call_local", "reliable")
func change_state(new_state : StringName, from_state : State = null) -> void:
	#exit current state, and disable the code from running
	states[current_state]._exit(new_state)
	states[current_state].set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	#enter new state, and make the new state run
	states[new_state]._enter(current_state)
	current_state = new_state
	states[current_state].set_process_mode(Node.PROCESS_MODE_INHERIT)
