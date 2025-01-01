extends Node
class_name StateMachine

var states := {}
@export var current_state := "":
	set(x):
		current_state = x
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

@rpc("authority", "call_local", "reliable")
func change_state(new_state : StringName, from_state : State = null) -> void:
	#exit current state, and disable the code from running
	states[current_state]._exit(new_state)
	states[current_state].set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	#enter new state, and make the new state run
	states[new_state]._enter(current_state)
	current_state = new_state
	states[current_state].set_process_mode(Node.PROCESS_MODE_INHERIT)
