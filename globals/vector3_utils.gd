class_name V3Utils

## Returns the Manhattan/Taxicab distance between two vectors.
static func distance_manhattan(a : Vector3, b : Vector3) -> float:
	return abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)

## Returns the Chebyshev distance between two vectors.
static func distance_chebyshev(a : Vector3, b : Vector3) -> float:
	return max(abs(a.x - b.x),
	max(abs(a.y - b.y),
	abs(a.z - b.z)))

## Similar to [code]Vector2.move_toward()[/code], except each axis does move_toward() logic individually. 
## Each axis may reach it's destination at different times.
static func move_toward_individual(position : Vector3, target : Vector3, delta : float = 1.0) -> Vector3:
	var x : float = move_toward(position.x, target.x, delta)
	var y : float = move_toward(position.y, target.y, delta)
	var z : float = move_toward(position.z, target.z, delta)
	return Vector3(x, y, z)

## Returns the Manhattan/Taxicab length of the vector.
static func length_manhattan(a : Vector3) -> float:
	return abs(a.x) + abs(a.y) + abs(a.z)

## Returns the Chebyshev length of the vector.
static func length_chebyshev(a : Vector3) -> float:
	return max(abs(a.x),
	max(abs(a.y),
	abs(a.z)))

## Vector3 rand_range() function.
static func rand_range(a : Vector3, b : Vector3) -> Vector3:
	var x := randf_range(a.x, b.x)
	var y := randf_range(a.y, b.y)
	var z := randf_range(a.z, b.z)
	return Vector3(x, y, z)

## Given a line segment [code]a_b[/code], return the closest colinear point to point [code]c[/code]
static func closest_point_on_line(a : Vector3, b : Vector3, c : Vector3) -> Vector3:
	b = (b - a).normalized()
	c = c - a
	return a + b * (c.dot(b))

## Given a line segment [code]a_b[/code], return the position on the line closest to point [code]c[/code].
## The returned point must remain between [code]a[/code] and [code]b[/code]
static func closest_point_on_line_clamped(a : Vector3, b : Vector3, c : Vector3) -> Vector3:
	b = (b - a).normalized()
	c = c - a
	return a + b * clamp(c.dot(b), 0.0, 1.0)

## Given a line segment [code]a_b[/code], return the percentage of the line segment closest to point [code]c[/code].
static func closest_point_on_line_normalized(a : Vector3, b : Vector3, c : Vector3) -> float:
	b = b - a
	c = c - a
	return c.dot(b.normalized()) / b.length()
