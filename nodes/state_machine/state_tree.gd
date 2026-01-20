extends Node
class_name StateTree

signal state_changed(to_state : StateTree)

var states := {}
@export var current_state : StateTree
var parent_state_machine : StateTree:
	get:
		if not is_inside_tree():
			return null
		if get_parent() is StateTree:
			return get_parent()
		
		return null

func _init() -> void:
	child_entered_tree.connect(on_child_entered_tree)
	child_exiting_tree.connect(on_child_exiting_tree)

func _ready() -> void:
	#initialize starting state
	if not current_state:
		current_state = NodeUtils.get_first_child_of_type(self, StateTree)
	if current_state:
		current_state.process_mode = Node.PROCESS_MODE_INHERIT
		current_state.state_enter(self)
		
		state_changed.emit(current_state)
	
	state_ready()

func on_child_entered_tree(node : Node) -> void:
	if node is StateTree:
		node.process_mode = Node.PROCESS_MODE_DISABLED

func on_child_exiting_tree(node : Node) -> void:
	pass

func change_state(to_state : StateTree) -> void:
	if parent_state_machine:
		parent_state_machine.child_requested_state_change(self, to_state)

func child_requested_state_change(from_state : StateTree, to_state : StateTree) -> void:
	#only allow changing to sibling states, no complicated long-distance tree traversal.
	if not from_state.get_parent() == to_state.get_parent():
		return
	
	await from_state.state_exit(to_state)
	# these process_mode assignments should maybe be worked around, because
	# they interfere with developer configuration options.
	#
	# in the meantime, process modes can be adjusted in the state_enter and state_exit functions
	# (state_exit would require call_deferred, because of execution order.)
	from_state.process_mode = Node.PROCESS_MODE_DISABLED
	
	current_state = to_state
	
	to_state.process_mode = Node.PROCESS_MODE_INHERIT
	await to_state.state_enter(self)
	
	#notify any parent state about the state change
	state_changed.emit(to_state)

#override 
func state_ready() -> void:
	pass
#override
func state_enter(from : StateTree) -> void:
	pass
#override
func state_exit(to_state : StateTree) -> void:
	pass

#override
func _process(delta : float) -> void:
	pass
#override
func _physics_process(delta : float) -> void:
	pass
#override
func _unhandled_input(event : InputEvent) -> void:
	pass
