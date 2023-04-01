# Physics3DUtils
## Functions
* `get_point_velocity(node : PhysicsBody3D, relative_position : Vector3) -> Vector3` Returns the point velocity of PhysicsBody3D `node` at `relative_position`. `relative_position` is in the global rotation space, but centered on `node`'s position.

### Proportional Navigation
* `true_proportional_navigation(proportionality_constant : float, closing_velocity : float, los_rate : Vector2) -> Vector2` Returns the rotation command necessary to intersect a targetted object. `los_rate` is the rate of change in angle of a line of sight vector from an observer to it's target. Similar to the way a moving object would pan across a camera's field of view.
* `augmented_proportional_navigation(proportionality_constant : float, closing_velocity : float, los_rate : Vector2, normal_acceleration : float, los_delta : Vector2) -> Vector2` Returns the rotation command necessary to intersect a targetted object. See `true_proportional_navigation()`. More accurate than `true_proportional_navigation()`, accounts for acceleration along the line of sight vector.