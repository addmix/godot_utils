@tool
extends EditorPlugin

var path : String = PluginUtils.get_plugin_path("Godot Utils")

#icons
const node_icon = preload("./icons/node.svg")
const node2d_icon = preload("./icons/node2d.svg")
const node3d_icon = preload("./icons/node3d.svg")
const area3d_icon = preload("./icons/Area3D.svg")

func _enter_tree() -> void:
	#plugin list settings
	var enable_plugin_list : bool = SettingsUtils.ifndef("godot_utils/plugin_list/enable", false)
	if enable_plugin_list:
		add_autoload_singleton("PluginList", path + "/singletons/plugin_list.gd")
	
	#floating origin settings
	var enable_floating_origin_helper : bool = SettingsUtils.ifndef("godot_utils/floating_origin/enable_helper", false)
	if enable_floating_origin_helper:
		add_autoload_singleton("FloatingOriginHelper", "res://addons/godot_utils/singletons/floating_origin_helper.gd")
	
	var enable_settings_manager : bool = SettingsUtils.ifndef("godot_utils/settings_manager/enabled_settings_manager", false)
	if enable_settings_manager:
		add_autoload_singleton("SettingsManager", "res://addons/godot_utils/singletons/settings_manager.gd")
	
	var enable_command_line_argument_parser : bool = SettingsUtils.ifndef("godot_utils/command_line_argument_parser/enable_command_line_argument_parser", false)
	if enable_command_line_argument_parser:
		add_autoload_singleton("CommandLineArgumentParser", "res://addons/godot_utils/singletons/command_line_argument_parser.gd")
	
	#resources
	add_custom_type("PID", "Resource", preload("./resources/pid.gd"), node_icon)
	add_custom_type("PIDVector2", "Resource", preload("./resources/pid_vector2.gd"), node_icon)
	add_custom_type("PIDVector3", "Resource", preload("./resources/pid_vector3.gd"), node_icon)
	add_custom_type("Spring", "Resource", preload("./resources/spring.gd"), node_icon)
	add_custom_type("Spring2D", "Resource", preload("./resources/spring2d.gd"), node2d_icon)
	add_custom_type("Spring3D", "Resource", preload("./resources/spring3d.gd"), node3d_icon)
	add_custom_type("SpringTransform", "Resource", preload("./resources/spring_transform3d.gd"), node3d_icon)

	#nodes
	add_custom_type("StateMachine", "Node", preload("./nodes/state_machine/state_machine.gd"), node_icon)
	add_custom_type("State", "Node", preload("./nodes/state_machine/state.gd"), node_icon)

	#nodes/3d

	add_custom_type("Point3D", "MeshInstance3D", preload("./nodes/3d/value_display/point_3d/point_3d.gd"), node3d_icon)
	add_custom_type("Vector3D", "MeshInstance3D", preload("./nodes/3d/value_display/vector_3d/vector_3d.gd"), node3d_icon)
	add_custom_type("FloatingOrigin", "Node3D", preload("./nodes/3d/floating_origin.gd"), node3d_icon)
	add_custom_type("FloatingOriginTopLevelFix", "Node", preload("./nodes/3d/floating_origin_top_level_fix.gd"), node_icon)
	add_custom_type("Thruster", "Marker3D", preload("./nodes/3d/physics/thruster.gd"), node3d_icon)
	
	#nodes/3d/physics
	add_custom_type("Area3DPreferredObjectPicker", "Area3D", preload("./nodes/3d/physics/area3d_preferred_object_picker.gd"), area3d_icon)

func _exit_tree() -> void:
	remove_custom_type("PID")
	remove_custom_type("PIDVector2")
	remove_custom_type("PIDVector3")
	remove_custom_type("Spring")
	remove_custom_type("Spring2D")
	remove_custom_type("Spring3D")
	remove_custom_type("SpringTransform")

	remove_custom_type("StateMachine")
	remove_custom_type("State")

	remove_custom_type("Point3D")
	remove_custom_type("Vector3D")
	remove_custom_type("FloatingOrigin")
	remove_custom_type("FloatingOriginTopLevelFix")
	remove_custom_type("Thruster")
	
	remove_custom_type("Area3DPreferredObjectPicker")
	
	if has_node("/root/PluginList"):
		remove_autoload_singleton("PluginList")
	
	if has_node("/root/FloatingOriginHelper"):
		remove_autoload_singleton("FloatingOriginHelper")
