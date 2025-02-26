class_name V2Utils


## Returns the Manhattan/Taxicab distance between two vectors.
static func distance_manhattan(a : Vector2, b : Vector2) -> float:
	return abs(a.x - b.x) + abs(a.y - b.y)

## Returns the Chebyshev distance between two vectors.
static func distance_chebyshev(a : Vector2, b : Vector2) -> float:
	return max(abs(a.x - b.x), abs(a.y - b.y))

## Checks if the supplied vectors are in a clockwise order.
static func is_clockwise(a : Vector2, b : Vector2, c : Vector2) -> bool:
	return (a - b).cross(a - c) > 0

## Similar to [code]Vector2.move_toward()[/code], except each axis does move_toward() logic individually. 
## Each axis may reach it's destination at different times.
static func move_toward_individual(position : Vector2, target : Vector2, delta : float = 1.0) -> Vector2:
	var x : float = move_toward(position.x, target.x, delta)
	var y : float = move_toward(position.y, target.y, delta)
	return Vector2(x, y)

## Returns the Manhattan/Taxicab length of the vector.
static func length_manhattan(a : Vector2) -> float:
	return abs(a.x) + abs(a.y)

## Returns the Chebyshev length of the vector.
static func length_chebyshev(a : Vector2) -> float:
	return max(abs(a.x), abs(a.y))

## Vector2 rand_range() function.
static func rand_range(a : Vector2, b : Vector2) -> Vector2:
	var x := randf_range(a.x, b.x)
	var y := randf_range(a.y, b.y)
	return Vector2(x, y)

## Given a line segment [code]a_b[/code], return the closest colinear point to point [code]c[/code]
static func closest_point_on_line(a : Vector2, b : Vector2, c : Vector2) -> Vector2:
	b = (b - a).normalized()
	c = c - a
	return a + b * (c.dot(b))

## Given a line segment [code]a_b[/code], return the position on the line closest to point [code]c[/code].
## The returned point must remain between [code]a[/code] and [code]b[/code]
static func closest_point_on_line_clamped(a : Vector2, b : Vector2, c : Vector2) -> Vector2:
	b = (b - a).normalized()
	c = c - a
	return a + b * clamp(c.dot(b), 0.0, 1.0)

## Given a line segment [code]a_b[/code], return the percentage of the line segment closest to point [code]c[/code].
static func closest_point_on_line_normalized(a : Vector2, b : Vector2, c : Vector3) -> float:
	b = b - a
	c = c - a
	return c.dot(b.normalized()) / b.length()