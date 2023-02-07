extends Node
class_name UnitUtils

static func meters_per_second_to_feet_per_second(ms : float) -> float:
	return meters_to_feet(ms)

static func meters_per_second_to_knots(ms : float) -> float:
	return ms * 1.9438444924406

static func meters_per_second_to_miles_per_hour(ms : float) -> float:
	return ms * 2.2369362912

static func meters_per_second_to_kilometers_per_hour(ms : float) -> float:
	return ms * 3.6

static func meters_to_feet(m : float) -> float:
	return m * 3.280839895

static func meters_to_kilometers(m : float) -> float:
	return m * 0.001

static func meters_to_miles(m : float) -> float:
	return m * 0.0006213712

static func meters_per_second_squared_to_gs(ms2 : float) -> float:
	return ms2 * 0.1019716213

static func meters_per_second_squared_to_feet_per_second_squared(ms2 : float) -> float:
	return meters_to_feet(ms2)
