extends Node
class_name UnitUtils

func meters_per_second_to_feet_per_second(ms : float) -> float:
	return meters_to_feet(ms)

func meters_per_second_to_knots(ms : float) -> float:
	return ms * 1.9438444924406

func meters_per_second_to_miles_per_hour(ms : float) -> float:
	return ms * 2.2369362912

func meters_per_second_to_kilometers_per_hour(ms : float) -> float:
	return ms * 3.6

func meters_to_feet(m : float) -> float:
	return m * 3.280839895

func meters_to_kilometers(m : float) -> float:
	return m * 0.001

func meters_to_miles(m : float) -> float:
	return m * 0.0006213712
