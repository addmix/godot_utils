class_name Physics3DUtils

#returns the necessary change in velocity to intercept, normal to the instantaneous velocity difference
func prop_nav_velocity(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()
	
	return (proportionality_constant * relative_target_velocity).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
func prop_nav_los(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()
	
	return (-proportionality_constant * relative_target_velocity.length() * relative_range.normalized()).cross(o)

#returns the necessary change in velocity to intercept, normal to the instantaneous line of sight
func prop_nav_conserve_energy(position : Vector3, velocity : Vector3, target_position : Vector3, target_velocity : Vector3, proportionality_constant : float = 4.0) -> Vector3:
	var relative_target_velocity : Vector3 = target_velocity - velocity
	var relative_range : Vector3 = target_position - position
	var o : Vector3 = (relative_range.cross(relative_target_velocity)) / relative_range.length_squared()
	
	return (-proportionality_constant * relative_target_velocity.length() * velocity.normalized()).cross(o)
