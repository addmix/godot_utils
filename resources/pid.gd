extends Resource
class_name PID

@export var p : float = 0.2
@export var i : float = 0.05
@export var d : float = 1.0

var output : float = 0

var _last_error : float
var _integral : float

func _init(_p : float, _i : float, _d : float) -> void:
	self.p = _p
	self.i = _i
	self.d = _d

func update(delta : float, error : float) -> float:
	var derivative : float = (error - _last_error) / delta
	_integral += error * delta
	_last_error = error

	output = p * error + i * _integral + d * derivative
	return output
