#class for 2D non-physics integrated springs, has to be explicitly updated using the positionvelocity() function.
#best used for springy interpolation of UI components and 2D games, doesn't play well with regular physics.
extends Resource

class_name Spring2D

@export var damper : float = 0
@export var speed : float = 1

@export var position := Vector2.ZERO
var x : float = 0.0:
	get:
		return position.x
var y : float = 0.0:
	get:
		return position.y
@export var velocity := Vector2.ZERO
@export var target := Vector2.ZERO
@export var mass : float = 1

#base funcs
func _init(d := 0.5, s := 1.0, p := Vector2(0, 0), v := Vector2(0, 0), t := Vector2(0, 0)) -> void:
	position = p
	velocity = v
	target = t
	damper = d
	speed = s

func get_class() -> String:
	return "Spring2D"


#this basically just runs 2 1d springs together
#im pretty sure this will be effected by gimbal lock
#physics funcs
func update(delta : float) -> void:
	if damper >= 1:
		return
	if speed == 0:
		push_error("Speed == 0 on Spring2D")

	var direction = position - target
	#round curve
	var curve = pow(1 - damper * damper, .5)
	#weird exponetial thingy
	var curve1 : Vector2 = (velocity / speed + damper * direction) / curve
	#hanging rope
	var cosine : float = cos(curve * speed * delta)
	#deflated bubble
	var sine : float = sin(curve * speed * delta)
	var e : float = pow(2.718281828459045, damper * speed * delta)

	position = target + (direction * cosine + curve1 * sine) / e
	velocity = speed * ((curve * curve1 - damper * direction) * cosine - (curve * direction + damper * curve1) * sine) / e

func apply_impulse(f : Vector2) -> void:
	velocity += f / mass

func accelerate(s : Vector2) -> void:
	velocity += s
