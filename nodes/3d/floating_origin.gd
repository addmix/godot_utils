extends Node3D
class_name FloatingOrigin

signal pre_origin_shift
signal origin_shifted

@export var disabled : bool = false
@export var shift_threshold : float = 1024.0
@export var shift_cooldown : float = 5.0
var _can_shift : bool = true

#current chunks of offset
var current_offset : Vector3i = Vector3i.ZERO
var global_offset : Vector3 = Vector3.ZERO

func _ready() -> void:
	if has_node("/root/FloatingOriginHelper"):
		get_node("/root/FloatingOriginHelper").floating_origin = self

func shift_origin(_position : Vector3) -> void:
	#get closest cell
	var change_in_cells := Vector3i()
	@warning_ignore("integer_division")
	change_in_cells.x = int(_position.x) / int(shift_threshold)
	@warning_ignore("integer_division")
	change_in_cells.y = int(_position.y) / int(shift_threshold)
	@warning_ignore("integer_division")
	change_in_cells.z = int(_position.z) / int(shift_threshold)

	pre_origin_shift.emit(Vector3(change_in_cells) * shift_threshold)

	#we'll see how well shifting the root node only will work
	global_position -= Vector3(change_in_cells) * shift_threshold

	current_offset += change_in_cells
	global_offset = Vector3(current_offset) * shift_threshold
	origin_shifted.emit(Vector3(change_in_cells) * shift_threshold)

func _physics_process(delta: float) -> void:
	if disabled:
		return
	var current_camera : Camera3D = get_viewport().get_camera_3d()
	if current_camera == null:
		return
	var camera_position : Vector3 = get_viewport().get_camera_3d().global_transform.origin
	if _can_shift and V3Utils.length_chebyshev(camera_position) > shift_threshold:
		_can_shift = false

		shift_origin.call_deferred(camera_position)
		await(get_tree().create_timer(shift_cooldown).timeout)
		_can_shift = true
