# Spring3D
## Variables
* `position : Vector3 = (0, 0, 0)`
* `x : float` Getter for the `position`'s x value
* `y : float` Getter for the `position`'s y value
* `z : float` Getter for the `position`'s z value
* `velocity : Vector3 = (0, 0, 0)`
* `target : Vector3 = (0, 0, 0)`
* `damper : float = 0.0` The amount of dampening applied to the spring. Expected range 0-1.
* `frequency : float = 1.0`
* `mass : float = 1.0`

## Functions
* `update(delta : float) -> void` Updates the spring.
* `apply_impulse(force : Vector3) -> void` Applies an impulse to the spring. Impulses are affected by the `mass` of the spring.
* `accelerate(speed : Vector3) -> void` Accelerates the spring. Ignores mass.
