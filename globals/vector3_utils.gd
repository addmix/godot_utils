class_name V3Utils


static func clamp(vector : Vector3, lower : Vector3, upper : Vector3) -> Vector3:
	return V3Utils.max(V3Utils.min(vector, upper), lower)

static func clamp_length(v : Vector3, length : float) -> Vector3:
	if v.length_squared() == 0:
		return v
	return v.normalized() * min(length, v.length())

static func distance_manhattan(a : Vector3, b : Vector3) -> float:
	return abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)

static func distance_chebyshev(a : Vector3, b : Vector3) -> float:
	return max(abs(a.x - b.x),
	max(abs(a.y - b.y),
	abs(a.z - b.z)))

static func move_toward(position : Vector3, target : Vector3, delta : float = 1.0) -> Vector3:
	var direction : Vector3 = target - position
	var distance_squared : float = direction.length_squared()
	return toggle(delta * delta > distance_squared, target, position + direction.normalized() * delta)

static func move_toward_individual(position : Vector3, target : Vector3, delta : float = 1.0) -> Vector3:
	var x : float = move_toward(position.x, target.x, delta)
	var y : float = move_toward(position.y, target.y, delta)
	var z : float = move_toward(position.z, target.z, delta)
	return Vector3(x, y, z)

static func length_manhattan(a : Vector3) -> float:
	return abs(a.x) + abs(a.y) + abs(a.z)

static func length_chebyshev(a : Vector3) -> float:
	return max(abs(a.x),
	max(abs(a.y),
	abs(a.z)))

static func lerp(a : Vector3, b : Vector3, c : Vector3) -> Vector3:
	return Vector3(lerp(a.x, b.x, c.x), lerp(a.y, b.y, c.y), lerp(a.z, b.z, c.z))

static func max(a : Vector3, b : Vector3) -> Vector3:
	return Vector3(max(a.x, b.x), max(a.y, b.y), max(a.z, b.z))

static func min(a : Vector3, b : Vector3) -> Vector3:
	return Vector3(min(a.x, b.x), min(a.y, b.y), min(a.z, b.z))

#Vector3 random range function
static func rand_range(a : Vector3, b : Vector3) -> Vector3:
	var x := randf_range(a.x, b.x)
	var y := randf_range(a.y, b.y)
	var z := randf_range(a.z, b.z)
	return Vector3(x, y, z)

static func toggle(condition : bool, _true : Vector3, _false : Vector3) -> Vector3:
	return float(condition) * _true + float(!condition) * _false

static func closest_point_on_line(a : Vector3, b : Vector3, c : Vector3) -> Vector3:
	b = (b - a).normalized()
	c = c - a
	return a + b * (c.dot(b))

#clamps between line lerp value 0 and 1
static func closest_point_on_line_clamped(a : Vector3, b : Vector3, c : Vector3) -> Vector3:
	b = (b - a).normalized()
	c = c - a
	return a + b * clamp(c.dot(b), 0.0, 1.0)

#gives lerp value of line, from 0 to 1
static func closest_point_on_line_normalized(a : Vector3, b : Vector3, c : Vector3) -> float:
	b = b - a
	c = c - a
	return c.dot(b.normalized()) / b.length()
