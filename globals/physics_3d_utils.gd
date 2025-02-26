class_name Physics3DUtils

## Returns the given node's center of mass in global space, taking body rotation into account.
static func get_center_of_mass_in_global_space(node : RigidBody3D) -> Vector3:
	return node.global_position + node.global_basis * node.center_of_mass


#https://github.com/godotengine/godot-proposals/issues/773
## Returns the velocity at a specific point relative to a RigidBody3D. This takes angular velocity into account.
static func get_point_velocity(node : RigidBody3D, relative_position : Vector3) -> Vector3:
	return node.linear_velocity + node.angular_velocity.cross(relative_position - node.center_of_mass);

# NOTICE: Hasn't been tested since some time in 3.x
static func true_proportional_navigation(los_rate : Vector2, closing_velocity : float, proportionality_constant : float = 4.0) -> Vector2:
	return proportionality_constant * closing_velocity * los_rate

# NOTICE: Hasn't been tested since some time in 3.x
static func augmented_proportional_navigation(los_rate : Vector2, closing_velocity : float, normal_acceleration : float, los_delta : Vector2, proportionality_constant : float = 4.0) -> Vector2:
	var tpn := true_proportional_navigation(los_rate, closing_velocity, proportionality_constant)
	return tpn + los_delta * normal_acceleration * (proportionality_constant / 2.0)
#	Vector2(tpn.x + (proportionality_constant * normal_acceleration) / 2.0, tpn.y + (proportionality_constant * normal_acceleration) / 2.0)#


###
### these functions aren't very good, nor very useful in realistic situations
###


#returns the necessary change in velocity to intercept, normal to the instantaneous velocity difference
# NOTICE: Hasn't been tested since some time in 3.x
static func proportional_navigation_velocity_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (proportionality_constant * relative_target_velocity).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
# NOTICE: Hasn't been tested since some time in 3.x
static func proportional_navigation_los_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (-proportionality_constant * relative_target_velocity.length() * relative_range.normalized()).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
# NOTICE: Hasn't been tested since some time in 3.x
static func proportional_navigation_conserve_energy_los_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (-proportionality_constant * relative_target_velocity.length() * velocity.normalized()).cross(o)

# NOTICE: Hasn't been tested since some time in 3.x
static func augmented_proportional_navigation_los_vector(closing_velocity : float, los_rate : Vector2, los_normal_acceleration : float) -> Vector2:
	var nsc : float = 3.0 * closing_velocity
	var half_n : float = 1.5
	return Vector2(nsc * los_rate.x + half_n * los_normal_acceleration, nsc * los_rate.y + half_n * los_normal_acceleration)
