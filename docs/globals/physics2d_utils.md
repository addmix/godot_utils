# Physics2DUtils

* `get_point_velocity(node : PhysicsBody2D, relative_position : Vector2) -> Vector2` Returns the point velocity of PhysicsBody2D `node` at the given `relative_position`.
* `proportional_navigation(delta : float, position : Vector2, velocity : Vector2, target_position : Vector2, target_velocity : Vector2, proportionality_constant : float = 4.0) -> float` Calculates proportional navigation. Returned value is the rotation that the velocity vector needs to achieve to collide with the target defined in `target_position`.
