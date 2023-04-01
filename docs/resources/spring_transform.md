# SpringTransform
## Variables
* `position_spring : Spring3D`
* `rotation_spring : Spring3D`
* `mass : float = 1.0`
* `center_of_mass : Vector3 = (0, 0, 0)`
* `inertia_tensor : Basis`

## Functions
* `update(delta : float) -> void` Updates the spring.
* `apply_impulse(_impulse : Vector3, _position : Vector3) -> void` Applies a positioned impulse on the SpringTransform.
* `accelerate(_position : Vector3, _rotation : Vector3) -> void` Accelerates the position and rotation springs.
