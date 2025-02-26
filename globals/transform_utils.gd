class_name TransformUtils

## Performs an addition matrix operation for two bases.
static func add_basis(a : Basis, b : Basis) -> Basis:
	return Basis(a.x + b.x, a.y + b.y, a.z + b.z)

## Performs a subtraction matrix operation for two bases.
static func subtract_basis(a : Basis, b : Basis) -> Basis:
	return Basis(a.x - b.x, a.y - b.y, a.z - b.z)

## Alias for [code]Quaternion.get_axis() * Quaternion.get_angle()[/code].
static func quat_to_axis_angle(quat : Quaternion) -> Vector4:
	return quat.get_axis() * quat.get_angle
