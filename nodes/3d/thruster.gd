extends Marker3D
class_name Thruster

@export var enabled : bool = true
@export var force : float = 100.0

func _physics_process(delta : float) -> void:
	if enabled:
		NodeUtils.get_first_parent_of_type(self, PhysicsBody3D).apply_force(-global_transform.basis.z * force, global_transform.basis * position)
