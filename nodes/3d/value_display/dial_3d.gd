extends Node3D
class_name Dial3D

## Value displayed by the Dial3D
@export var value : float = 0.0:
	set(x):
		value = MathUtils.float_toggle(_clamp, clamp(x, min_value, max_value), x)
		var rotate : float = remap(value, min_value, max_value, min_rotation, max_rotation)
		basis = default_transform.basis.rotated(default_transform.basis.y, -rotate)

## The minimum value of the Dial3D
@export var min_value : float = 0.0
## The maximum value of the Dial3D
@export var max_value : float = 1.0
## The rotation (in radians) that coincides with [code]min_value[/code]
@export var min_rotation : float = 0.0
## The rotation (in radians) that coincides with [code]max_value[/code]
@export var max_rotation : float = deg_to_rad(180.0)
## If enabled, rotation will be clamped between [code]min_rotation[/code] and [code]max_rotation[/code]
@export var _clamp : bool = false

## Internal value used for positioning
@onready var default_transform : Transform3D = transform
