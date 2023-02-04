extends ValueDisplay
class_name Dial

@export var value : float = 0.0:
	set(x):
		value = MathUtils.float_toggle(_clamp, clamp(x, min_value, max_value), x)
		var rotate : float = remap(value, min_value, max_value, min_rotation, max_rotation)
		basis = default_transform.basis.rotated(default_transform.basis.y, -rotate)

@export var min_value : float = 0.0
@export var max_value : float = 1.0
@export var min_rotation : float = 0.0
@export var max_rotation : float = deg_to_rad(180.0)
@export var _clamp : bool = false

@onready var default_transform : Transform3D = transform
