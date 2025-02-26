extends Marker3D
class_name Thruster

## This node can be added as a descendant of a RigidBody3D, and it will apply a constant force to it.

## If enabled, this node will apply a constant [code]force[/code] in the local -Z direction.
@export var enabled : bool = true
## Force, in newtons that the current node will apply to the first ancestor RigidBody3D.
@export var force : float = 100.0

func _physics_process(delta : float) -> void:
	var rigidbody : RigidBody3D = NodeUtils.get_first_parent_of_type(self, RigidBody3D)
	if rigidbody and enabled:
		rigidbody.apply_force(-global_transform.basis.z * force, global_transform.basis * position)
