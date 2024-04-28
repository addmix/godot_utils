class_name TransformUtils

static func quat_to_axis_angle(quat : Quaternion) -> Vector4:
	var axis_angle := Vector4(0, 0, 0, 0)

	if quat.w > 1: #if w>1 acos and sqrt will produce errors, this cant happen if quaternion is normalised
		quat = quat.normalized()

	var angle = 2.0 * acos(quat.w)
	axis_angle.w = sqrt(1 - quat.w * quat.w) #assuming quaternion normalised then w is less than 1, so term always positive.

	if is_equal_approx(axis_angle.w, 0.0): #test to avoid divide by zero, s is always positive due to sqrt
		axis_angle.x = quat.x
		axis_angle.y = quat.y
		axis_angle.z = quat.z
	else:
		axis_angle.x = quat.x / axis_angle.w
		axis_angle.y = quat.y / axis_angle.w
		axis_angle.z = quat.z / axis_angle.w

	return axis_angle
