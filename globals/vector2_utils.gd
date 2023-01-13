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

static func lerp(a : Vector2, b : Vector2, c : Vector2) -> Vector2:
	return Vector2(lerp(a.x, b.x, c.x), lerp(a.y, b.y, c.y))

static func max(a : Vector2, b : Vector2) -> Vector2:
	return Vector2(max(a.x, b.x), max(a.y, b.y))

static func min(a : Vector2, b : Vector2) -> Vector2:
	return Vector2(min(a.x, b.x), min(a.y, b.y))

#Vector3 random range function
static func rand_range(a : Vector2, b : Vector2) -> Vector2:
	var x := randf_range(a.x, b.x)
	var y := randf_range(a.y, b.y)
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
