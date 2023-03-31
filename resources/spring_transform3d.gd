#class for 3D non-physics integrated springs, has to be explicitly updated using the positionvelocity() function.
#best for objects in 3D space, such as guns with recoil and bobbles.
extends Resource

class_name SpringRecoil

@export var position_spring := Spring3D.new()
var position : Vector3:
	get:
		return position_spring.position

@export var rotation_spring := Spring3D.new()
var rotation : Vector3:
	get:
		return rotation_spring.position

@export_group("Mass and Interia")
@export var mass : float = 1.0
@export var center_of_mass := Vector3(0, 0, 0)
@export var inertia_tensor := Basis():
	set(x):
		inertia_tensor = x
		inverse_inertia_tensor = x.inverse()
var inverse_inertia_tensor := Basis()
func get_inverse_inertia_tensor() -> Basis:
	return inverse_inertia_tensor

@export_group("")

func get_class() -> String:
	return "SpringTransform3D"

func update(delta : float) -> void:
	position_spring.update(delta)
	rotation_spring.update(delta)

func apply_impulse(_impulse : Vector3, _position : Vector3) -> void:
	position_spring.accelerate(_impulse / mass)

	var torque : Vector3 = (_position - center_of_mass).cross(_impulse)
	var torque_in_diagonal_space : Vector3 = inverse_inertia_tensor * torque
	var angular_velocity_change_in_diagonal_space : Vector3
	angular_velocity_change_in_diagonal_space.x = torque_in_diagonal_space.x / get_inverse_inertia_tensor().x.length()
	angular_velocity_change_in_diagonal_space.y = torque_in_diagonal_space.y / get_inverse_inertia_tensor().y.length()
	angular_velocity_change_in_diagonal_space.z = torque_in_diagonal_space.z / get_inverse_inertia_tensor().z.length()

	rotation_spring.accelerate(get_inverse_inertia_tensor() * angular_velocity_change_in_diagonal_space)

func accelerate(_position : Vector3, _rotation : Vector3) -> void:
	position_spring.accelerate(_position)
	rotation_spring.accelerate(_rotation)
