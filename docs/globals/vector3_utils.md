# V3Utils
## Functions
* `move_toward_individual(position : Vector3, target : Vector3, delta : float = 1.0) -> Vector3` Moves each axis towards `target` individually.
* `rand_range(a : Vector3, b : Vector3) -> Vector3`
* `closest_point_on_line(a : Vector3, b : Vector3, c : Vector3) -> Vector3`
* `closest_point_on_line_clamped(a : Vector3, b : Vector3, c : Vector3) -> Vector3`
* `closest_point_on_line_normalized(a : Vector3, b : Vector3, c : Vector3) -> float`

### Distance functions
* `distance_manhattan(a : Vector3, b : Vector3) -> float` Returns the distance between `a` and `b` using the manhattan (taxicab) distance formula.
* `distance_chebyshev(a : Vector3, b : Vector3) -> float` Returns the distance between `a` and `b` using the chebyshev distance formula.

### Length functions
* `clamp_length(v : Vector3, length : float) -> Vector3` Limits the length of vector `v` to `length`.
* `length_manhattan(a : Vector3) -> float`
* `length_chebyshev(a : Vector3) -> float`

