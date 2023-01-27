@tool
extends EditorPlugin

var base_dir : String = "res://addons/godot_utils/"

func _enter_tree() -> void:
	#resources
	add_custom_type("PID", "Resource", load(base_dir + "resources/pid.gd"), Texture2D.new())
	add_custom_type("Spring", "Resource", load(base_dir + "resources/spring.gd"), Texture2D.new())
	add_custom_type("Spring2D", "Resource", load(base_dir + "resources/spring2d.gd"), Texture2D.new())
	add_custom_type("Spring3D", "Resource", load(base_dir + "resources/spring3d.gd"), Texture2D.new())
	add_custom_type("SpringTransform", "Resource", load(base_dir + "resources/spring_transform.gd"), Texture2D.new())

	#nodes
	add_custom_type("StateMachine", "Node", load(base_dir + "nodes/state_machine/state_machine.gd"), Texture2D.new())
	add_custom_type("State", "Node", load(base_dir + "nodes/state_machine/state.gd"), Texture2D.new())

	#nodes/3d
	add_custom_type("Vector3D", "MeshInstance3D", load(base_dir + "nodes/3d/vector_3d/vector_3d.gd"), Texture2D.new())

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
