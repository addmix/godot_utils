extends Resource
class_name PIDVector2

@export var p : Vector2 = Vector2(0.2, 0.2)
@export var i : Vector2 = Vector2(0.05, 0.05)
@export var d : Vector2 = Vector2(1.0, 1.0)

@export_category("Clamp Integral")
@export var clamp_integral : bool = false
@export var min_integral : Vector2 = Vector2(-1.0, -1.0)
@export var max_integral : Vector2 = Vector2(1.0, 1.0)
@export_category("")

var output : Vector2 = Vector2.ZERO

var _last_error : Vector2 = Vector2.ZERO
var _integral_error : Vector2 = Vector2.ZERO

var proportional_output : Vector2 = Vector2.ZERO
var integral_output : Vector2 = Vector2.ZERO
var derivative_output : Vector2 = Vector2.ZERO

func _init(_p : Vector2 = p, _i : Vector2 = i, _d : Vector2 = d) -> void:
	self.p = _p
	self.i = _i
	self.d = _d

func update(delta : float, error : Vector2) -> Vector2:
	var derivative : Vector2 = (error - _last_error) / delta
	_integral_error += error * delta
	_integral_error = V2Utils.toggle(clamp_integral, clamp(_integral_error, min_integral, max_integral), _integral_error)
	_last_error = error
	
	proportional_output = p * error
	integral_output = i * _integral_error
	derivative_output = d * derivative
	
	output = proportional_output + integral_output + derivative_output
	return output
