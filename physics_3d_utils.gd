class_name Physics3DUtils


static func tpn(proportionality_constant : float, closing_velocity : float, los_rate : Vector2) -> Vector2:
	return proportionality_constant * closing_velocity * los_rate

static func apn(proportionality_constant : float, closing_velocity : float, los_rate : Vector2, normal_acceleration : float, los_delta : Vector2) -> Vector2:
	var tpn := tpn(proportionality_constant, closing_velocity, los_rate)
	return tpn + los_delta * normal_acceleration * (proportionality_constant / 2.0)
#	Vector2(tpn.x + (proportionality_constant * normal_acceleration) / 2.0, tpn.y + (proportionality_constant * normal_acceleration) / 2.0)#


###
### these functions aren't very good, nor very useful in realistic situations
###


#returns the necessary change in velocity to intercept, normal to the instantaneous velocity difference
static func prop_nav_velocity_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (proportionality_constant * relative_target_velocity).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
static func prop_nav_los_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (-proportionality_constant * relative_target_velocity.length() * relative_range.normalized()).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
static func prop_nav_conserve_energy_vector(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()

	return (-proportionality_constant * relative_target_velocity.length() * velocity.normalized()).cross(o)

static func augmented_prop_nav(closing_velocity : float, los_rate : Vector2, los_normal_acceleration : float) -> Vector2:
	var nsc : float = 3.0 * closing_velocity
	var half_n : float = 1.5
	return Vector2(nsc * los_rate.x + half_n * los_normal_acceleration, nsc * los_rate.y + half_n * los_normal_acceleration)
