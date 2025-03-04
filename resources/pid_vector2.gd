extends Resource
class_name PIDVector2

## A Resource class used to calculate PID control responses. [br]
## Resources behave as shared instances. For most cases, be sure that PID resources have [code]local_to_scene[/code] set to true, or creating and assigning a duplicate (example: inside _init() or _ready() [code]pid = pid.duplicate()[/code])

## Proportional gain. (Applies a factor based on the error magnitude.)
@export var p : Vector2 = Vector2(0.2, 0.2)
## Integral gain. (Applies a factor based on the sum of the error over time.)
@export var i : Vector2 = Vector2(0.05, 0.05)
## Derivative gain. (Applies a factor based on the measured velocity of the error.)
@export var d : Vector2 = Vector2(1.0, 1.0)

@export_category("Clamp Integral")
## If true, [code]_integral_error[/code] is clamped between [code]min_integral[/code] and [code]max_integral[/code]
@export var clamp_integral : bool = false
## The minimum value used when [code]clamp_integral[/code] is enabled.
@export var min_integral : Vector2 = Vector2(-1.0, -1.0)
## The maximum value used when [code]clamp_integral[/code] is enabled.
@export var max_integral : Vector2 = Vector2(1.0, 1.0)
@export_category("")

## The output value of the PID algorithm. This value is also returned by [code]update()[/code]. [br]
var output : Vector2 = Vector2.ZERO

## The error measured during the last call to [code]update()[/code]
var _last_error : Vector2 = Vector2.ZERO
## Sum of error over time. (see: [code]clamp_integral[/code])
var _integral_error : Vector2 = Vector2.ZERO

## Proportional output component of the PID. Equal to [code]p * error[/code]
var proportional_output : Vector2 = Vector2.ZERO
## Integral output component of the PID. Equal to [code]i * _integral_error[/code]
var integral_output : Vector2 = Vector2.ZERO
## Derivative output component of the PID. Equal to [code]d * error velocity[/code]
var derivative_output : Vector2 = Vector2.ZERO

func _init(_p : Vector2 = p, _i : Vector2 = i, _d : Vector2 = d) -> void:
	self.p = _p
	self.i = _i
	self.d = _d

## Updates the PID and returns a corrective input. [br]
## This does not have to be called every frame, however [code]delta[/code] must be the time elapsed since the last call. [br]
## [code]error[/code] is the error that is trying to be corrected. 
func update(delta : float, error : Vector2) -> Vector2:
	var derivative : Vector2 = (error - _last_error) / delta
	_integral_error += error * delta
	_integral_error = MathUtils.toggle(clamp_integral, clamp(_integral_error, min_integral, max_integral), _integral_error)
	_last_error = error
	
	proportional_output = p * error
	integral_output = i * _integral_error
	derivative_output = d * derivative
	
	output = proportional_output + integral_output + derivative_output
	return output
