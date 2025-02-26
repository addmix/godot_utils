@tool
extends Node3D
class_name FloatingOrigin

## Signal emitted immediately before the origin shifts.
signal pre_origin_shift(shift : Vector3)
## Signal emitted immediately after the origin shifts.
signal origin_shifted(shift : Vector3)

## When [code]true[/code], the floating origin will not update any logic.
@export var disabled : bool = false
## When [code]true[/code], the floating origin will not shift on the Y axis.
@export var disable_y_shift : bool = false
## Unit size that origin shifts are rounded to. Also acts as the distance away from the origin that triggers an origin shift.
@export var shift_threshold : float = 1024.0
## Time in seconds used to prevent rapid origin shifts.
@export var shift_cooldown : float = 5.0
## Internal variable used for [code]shift_cooldown[/code] logic.
var _can_shift : bool = true

## The amount of [code]shift_threshold[/code]-sized units tha the floating origin is currently shifted. (see: global_offset)
var current_offset : Vector3i = Vector3i.ZERO
## The total offset of the floating origin. (see: current_offset)
var global_offset : Vector3 = Vector3.ZERO

@export_group("Editor")
## If enabled, floating origin will shift in the editor.
@export var can_shift_in_editor : bool = false

func _ready() -> void:
	if has_node("/root/FloatingOriginHelper"):
		get_node("/root/FloatingOriginHelper").floating_origin = self
	
	#prevents issues from shifting in editor
	position = Vector3.ZERO

## This is called automatically by the floating origin when the current camera's position exceeds [code]shift_threshold[/code] distance from the world origin. [br]
## _position is the camera's global position, without any modification or adjustment.
func shift_origin(_position : Vector3) -> void:
	#get closest cell
	var change_in_cells := Vector3i()
	@warning_ignore("integer_division")
	change_in_cells.x = int(_position.x) / int(shift_threshold)
	@warning_ignore("integer_division")
	change_in_cells.y = int(_position.y) / int(shift_threshold)
	@warning_ignore("integer_division")
	change_in_cells.z = int(_position.z) / int(shift_threshold)
	
	if disable_y_shift:
		change_in_cells.y = 0
	
	pre_origin_shift.emit(Vector3(change_in_cells) * shift_threshold)

	#we'll see how well shifting the root node only will work
	global_position -= Vector3(change_in_cells) * shift_threshold

	current_offset += change_in_cells
	global_offset = Vector3(current_offset) * shift_threshold
	origin_shifted.emit(Vector3(change_in_cells) * shift_threshold)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint() and not can_shift_in_editor:
		return
	
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
