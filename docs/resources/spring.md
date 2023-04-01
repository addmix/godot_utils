# Spring
## Variables
* `damper : float = 0.0` The amount of dampening applied to the spring. Expected range 0-1.
* `speed : float = 1.0`
* `position : float = 0.0`
* `velocity : float = 0.0`
* `target : float = 0.0`
* `mass : float = 1.0`

## Functions
* `update(delta : float) -> void` Updates the spring.
* `apply_impulse(force : float) -> void` Applies an impulse to the spring. Impulses are affected by the `mass` of the spring.
* `accelerate(speed : float) -> void` Accelerates the spring. Ignores mass.
