extends Resource
class_name PID

@export var p : float = 0.2
@export var i : float = 0.05
@export var d : float = 1.0

@export_category("Clamp Integral")
@export var clamp_integral : bool = false
@export var min_integral : float = -1
@export var max_integral : float = 1
@export_category("")

var output : float = 0

var _last_error : float
var _integral_error : float

var proportional_output : float = 0.0
var integral_output : float = 0.0
var derivative_output : float = 0.0

func _init(_p : float = p, _i : float = i, _d : float = d) -> void:
	self.p = _p
	self.i = _i
	self.d = _d

func update(delta : float, error : float) -> float:
	var derivative : float = (error - _last_error) / delta
	_integral_error += error * delta
	_integral_error = MathUtils.float_toggle(clamp_integral, clamp(_integral_error, min_integral, max_integral), _integral_error)
	_last_error = error
	
	proportional_output = p * error
	integral_output = i * _integral_error
	derivative_output = d * derivative
	
	output = proportional_output + integral_output + derivative_output
	return output
