extends Area3D
class_name Area3DPreferredObjectPicker

var nodes_in_area : Array = []
var preferred_node : Node3D = null

#these don't handle being changed after initialization
@export var pick_areas : bool = true
@export var pick_bodies : bool = true

func _ready() -> void:
	if pick_areas:
		connect("area_entered", _on_function_grab_area_entered)
		connect("area_exited", _on_function_grab_area_exited)
	if pick_bodies:
		connect("body_entered", _on_function_grab_body_entered)
		connect("body_exited", _on_function_grab_body_exited)

func _physics_process(_delta : float) -> void:
	_update_preferred_node()

func _on_function_grab_area_entered(area : Area3D) -> void:
	nodes_in_area.push_back(area)
	_update_preferred_node()

func _on_function_grab_area_exited(area : Area3D) -> void:
	if nodes_in_area.has(area):
		nodes_in_area.erase(area)
		_update_preferred_node()

func _on_function_grab_body_entered(body : Node3D) -> void:
	nodes_in_area.push_back(body)
	_update_preferred_node()

func _on_function_grab_body_exited(body : Node3D) -> void:
	if nodes_in_area.has(body):
		nodes_in_area.erase(body)
		_update_preferred_node()

func _update_preferred_node() -> void:
	if nodes_in_area.size() == 0:
		preferred_node = null
		return
	
	#choose the preferred node
	var new_preferred_node = preferred_node
	for node in nodes_in_area:
		preferred_node = _choose_preferred_node(node, new_preferred_node)

#if there is no preference between node a and node b, node a is returned
func _choose_preferred_node(node_a : Node3D, node_b : Node3D) -> Node3D:
	if not is_instance_valid(node_a):
		return node_b
	elif not is_instance_valid(node_b):
		return node_a
	var distance_a : float = global_transform.origin.distance_squared_to(node_a.global_transform.origin)
	var distance_b : float = global_transform.origin.distance_squared_to(node_b.global_transform.origin)
	if distance_a <= distance_b:
		return node_a
	else:
		return node_b
