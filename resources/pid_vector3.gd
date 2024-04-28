extends Resource
class_name PIDVector3

@export var p : Vector3 = Vector3(0.2, 0.2, 0.2)
@export var i : Vector3 = Vector3(0.05, 0.05, 0.05)
@export var d : Vector3 = Vector3(1.0, 1.0, 1.0)

@export_category("Clamp Integral")
@export var clamp_integral : bool = false
@export var min_integral : Vector3 = Vector3(-1.0, -1.0, -1.0)
@export var max_integral : Vector3 = Vector3(1.0, 1.0, 1.0)
@export_category("")

var output : Vector3 = Vector3.ZERO

var _last_error : Vector3 = Vector3.ZERO
var _integral_error : Vector3 = Vector3.ZERO

var proportional_output : Vector3 = Vector3.ZERO
var integral_output : Vector3 = Vector3.ZERO
var derivative_output : Vector3 = Vector3.ZERO

func _init(_p : Vector3 = p, _i : Vector3 = i, _d : Vector3 = d) -> void:
	self.p = _p
	self.i = _i
	self.d = _d

func update(delta : float, error : Vector3) -> Vector3:
	var derivative : Vector3 = (error - _last_error) / delta
	_integral_error += error * delta
	_integral_error = V3Utils.toggle(clamp_integral, clamp(_integral_error, min_integral, max_integral), _integral_error)
	_last_error = error
	
	proportional_output = p * error
	integral_output = i * _integral_error
	derivative_output = d * derivative
	
	output = proportional_output + integral_output + derivative_output
	return output
