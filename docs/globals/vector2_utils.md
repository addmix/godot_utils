# V2Utils
## Functions
* `move_toward_individual(position : Vector2, target : Vector2, delta : float = 1.0) -> Vector2` Moves each axis towards `target` individually.
* `rand_range(a : Vector2, b : Vector2) -> Vector2`
* `closest_point_on_line_clamped(a : Vector2, b : Vector2, c : Vector2) -> Vector2`
* `closest_point_on_line(a : Vector2, b : Vector2, c : Vector2) -> Vector2`

### Distance functions
* `distance_manhattan(a : Vector2, b : Vector2) -> float` Returns the distance between `a` and `b` using the manhattan (taxicab) distance formula.
* `distance_chebyshev(a : Vector2, b : Vector2) -> float` Returns the distance between `a` and `b` using the chebyshev distance formula.

### Length functions
* `clamp_length(v : Vector2, length : float) -> Vector2` Limits the length of vector `v` to `length`.
* `length_manhattan(a : Vector2) -> float`
* `length_chebyshev(a : Vector2) -> float`

