@tool
extends EditorPlugin

#icons
const node_icon = preload("./icons/node.svg")
const node2d_icon = preload("./icons/node2d.svg")
const node3d_icon = preload("./icons/node3d.svg")

#resources
const pid = preload("./resources/pid.gd")
const spring = preload("./resources/spring.gd")
const spring2d = preload("./resources/spring2d.gd")
const spring3d = preload("./resources/spring3d.gd")
const spring_transform = preload("./resources/spring_transform.gd")

#nodes
const state_machine = preload("./nodes/state_machine/state_machine.gd")
const state = preload("./nodes/state_machine/state.gd")

#nodes/3d
const vector_3d = preload("./nodes/3d/vector_3d/vector_3d.gd")

func _enter_tree() -> void:
	#resources
	add_custom_type("PID", "Resource", pid, node_icon)
	add_custom_type("Spring", "Resource", spring, node_icon)
	add_custom_type("Spring2D", "Resource", spring2d, node2d_icon)
	add_custom_type("Spring3D", "Resource", spring3d, node3d_icon)
	add_custom_type("SpringTransform", "Resource", spring_transform, node3d_icon)

	#nodes
	add_custom_type("StateMachine", "Node", state_machine, node_icon)
	add_custom_type("State", "Node", state, node_icon)

	#nodes/3d
	add_custom_type("Vector3D", "MeshInstance3D", vector_3d, node3d_icon)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
