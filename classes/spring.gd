#class for 1D non-physics integrated springs, has to be explicitly updated using the positionvelocity() function.
extends Resource

class_name Spring

var position : float = 0
var velocity : float = 0
var target : float = 0
var damper : float = 0
var speed : float = 1
var mass : float = 1

func _init(p : float, v : float, t : float, d : float, s : float) -> void:
	position = p
	velocity = v
	target = t
	damper = d
	speed = s

func get_class() -> String:
	return "Spring"

#returns position, velocity
func positionvelocity(delta : float) -> void:
	if damper >= 1:
		return
	if speed == 0:
		push_error("Speed == 0 on Spring")
	
	var direction = position - target
	
	#round curve
	var curve = pow(1 - pow(damper, 2), .5)
	
	#weird exponetial thingy
	var curve1 = (velocity / speed + damper * direction) / curve
	
	#hanging rope
	var cosine = cos(curve * speed * delta)
	
	#deflated bubble
	var sine = sin(curve * speed * delta)
	
	var e = pow(2.718281828459045, damper * speed * delta)
	
	position = target + (direction * cosine + curve1 * sine) / e
	velocity = speed * ((curve * curve1 - damper * direction) * cosine - (curve * direction + damper * curve1) * sine) / e

func apply_force(force : float) -> void:
	velocity += force / mass

# warning-ignore:shadowed_variable
func accelerate(speed : float) -> void:
	velocity += speed
