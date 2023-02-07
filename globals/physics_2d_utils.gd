class_name Physics2DUtils

#https://github.com/godotengine/godot-proposals/issues/773
static func get_point_velocity(node : PhysicsBody2D, relative_position : Vector2) -> Vector2:
	return node.linear_velocity + Vector2(-node.angular_velocity * relative_position.y, node.angular_velocity * relative_position.x);

#returns the change in line of sight necessary to collide
static func proportional_navigation(delta : float, position : Vector2, velocity : Vector2, target_position : Vector2, target_velocity : Vector2, proportionality_constant : float = 4.0) -> float:
	var relative_position : Vector2 = position - target_position
	var closing_velocity : float = -((velocity - target_velocity).dot(relative_position) / relative_position.length())

	var prev_position : Vector2 = position - velocity * delta
	var target_prev_position : Vector2 = target_position - target_velocity * delta

	var prev_los : float = velocity.angle_to(target_prev_position - prev_position)
	var los : float = velocity.angle_to(target_position - position)

	var los_rate : float = (prev_los - los) / delta
	return proportionality_constant * los_rate * closing_velocity
