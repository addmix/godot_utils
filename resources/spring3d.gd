#class for 3D non-physics integrated springs, has to be explicitly updated using the positionvelocity() function.
#best for objects in 3D space, such as guns with recoil and bobbles.
extends Resource

class_name Spring3D

@export var position := Vector3.ZERO
var x : float = 0.0:
	get:
		return position.x
var y : float = 0.0:
	get:
		return position.y
var z : float = 0.0:
	get:
		return position.z
@export var velocity := Vector3.ZERO
@export var target := Vector3.ZERO
@export var damper : float = 0
@export var frequency : float = 1
@export var mass : float = 1

#base funcs
func _init(d := 0.5, f := 1.0, p := Vector3(0, 0, 0), v := Vector3(0, 0, 0), t := Vector3(0, 0, 0)) -> void:
	position = p
	velocity = v
	target = t
	damper = d
	frequency = f

func get_class() -> String:
	return "Spring3D"


#this basically just runs 3 1d springs together
#im pretty sure this will be effected by gimbal lock
#physics funcs
func update(delta : float) -> void:
	if damper >= 1:
		return
	if frequency == 0:
		push_error("Speed == 0 on Spring3D")

	var direction = position - target
	#round curve
	var curve = pow(1 - damper * damper, .5)
	#weird exponetial thingy
	var curve1 : Vector3 = (velocity / frequency + damper * direction) / curve
	#hanging rope
	var cosine : float = cos(curve * frequency * delta)
	#deflated bubble
	var sine : float = sin(curve * frequency * delta)
	var e : float = pow(2.718281828459045, damper * frequency * delta)

	position = target + (direction * cosine + curve1 * sine) / e
	velocity = frequency * ((curve * curve1 - damper * direction) * cosine - (curve * direction + damper * curve1) * sine) / e

func apply_impulse(_impulse : Vector3) -> void:
	accelerate(_impulse / mass)

func accelerate(s : Vector3) -> void:
	velocity += s
