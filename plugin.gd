@tool
extends EditorPlugin

var path : String = PluginUtils.get_plugin_path("Godot Utils")

#icons
const node_icon = preload("./icons/node.svg")
const node2d_icon = preload("./icons/node2d.svg")
const node3d_icon = preload("./icons/node3d.svg")

func _enter_tree() -> void:
	add_autoload_singleton("PluginList", path + "/singletons/plugin_list.gd")
	
	#resources
	add_custom_type("PID", "Resource", preload("./resources/pid.gd"), node_icon)
	add_custom_type("Spring", "Resource", preload("./resources/spring.gd"), node_icon)
	add_custom_type("Spring2D", "Resource", preload("./resources/spring2d.gd"), node2d_icon)
	add_custom_type("Spring3D", "Resource", preload("./resources/spring3d.gd"), node3d_icon)
	add_custom_type("SpringTransform", "Resource", preload("./resources/spring_transform3d.gd"), node3d_icon)

	#nodes
	add_custom_type("StateMachine", "Node", preload("./nodes/state_machine/state_machine.gd"), node_icon)
	add_custom_type("State", "Node", preload("./nodes/state_machine/state.gd"), node_icon)

	#nodes/3d
	add_custom_type("Vector3D", "MeshInstance3D", preload("./nodes/3d/vector_3d/vector_3d.gd"), node3d_icon)
	add_custom_type("FloatingOrigin", "Node3D", preload("./nodes/3d/floating_origin.gd"), node3d_icon)
	add_custom_type("Thruster", "Marker3D", preload("./nodes/3d/thruster.gd"), node3d_icon)

func _exit_tree() -> void:
	remove_custom_type("PID")
	remove_custom_type("Spring")
	remove_custom_type("Spring2D")
	remove_custom_type("Spring3D")
	remove_custom_type("SpringTransform")

	remove_custom_type("StateMachine")
	remove_custom_type("State")

	remove_custom_type("Vector3D")
