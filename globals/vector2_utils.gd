class_name V2Utils


static func clamp(vector : Vector2, lower : Vector2, upper : Vector2) -> Vector2:
	return max(min(vector, upper), lower)

static func clamp_length(v : Vector2, length : float) -> Vector2:
	if v.length_squared() == 0:
		return v
	return v.normalized() * min(length, v.length())

static func distance_manhattan(a : Vector2, b : Vector2) -> float:
	return abs(a.x - b.x) + abs(a.y - b.y)

static func distance_chebyshev(a : Vector2, b : Vector2) -> float:
	return max(abs(a.x - b.x), abs(a.y - b.y))

static func move_toward(position : Vector2, target : Vector2, delta : float = 1.0) -> Vector2:
	var direction : Vector2 = target - position
	var distance_squared : float = direction.length_squared()
	return toggle(delta * delta > distance_squared, target, position + direction.normalized() * delta)

static func move_toward_individual(position : Vector2, target : Vector2, delta : float = 1.0) -> Vector2:
	var x : float = move_toward(position.x, target.x, delta)
	var y : float = move_toward(position.y, target.y, delta)
	return Vector2(x, y)

static func length_manhattan(a : Vector2) -> float:
	return abs(a.x) + abs(a.y)

static func length_chebyshev(a : Vector2) -> float:
	return max(abs(a.x), abs(a.y))

static func lerp(v0 : Vector2, v1 : Vector2, v2 : Vector2) -> Vector2:
	return Vector2(lerp(v0.x, v1.x, v2.x), lerp(v0.y, v1.y, v2.y))

static func max(v0 : Vector2, v1 : Vector2) -> Vector2:
	return Vector2(max(v0.x, v1.x), max(v0.y, v1.y))

static func min(v0 : Vector2, v1 : Vector2) -> Vector2:
	return Vector2(min(v0.x, v1.x), min(v0.y, v1.y))

#Vector3 random range function
static func rand_range(v0 : Vector2, v1 : Vector2) -> Vector2:
	var x := randf_range(v0.x, v1.x)
	var y := randf_range(v0.y, v1.y)
	return Vector2(x, y)

static func toggle(condition : bool, _true : Vector2, _false : Vector2) -> Vector2:
	return float(condition) * _true + float(!condition) * _false

static func closest_point_on_line_clamped(a : Vector2, b : Vector2, c : Vector2) -> Vector2:
	b = (b - a).normalized()
	c = c - a
	return a + b * clamp(c.dot(b), 0.0, 1.0)

static func closest_point_on_line(a : Vector2, b : Vector2, c : Vector2) -> Vector2:
	b = (b - a).normalized()
	c = c - a
	return a + b * (c.dot(b))
