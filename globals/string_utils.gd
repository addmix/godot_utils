class_name StringUtils

const NOTATION : Array = ["", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD", "QAD", "QID", "SXD", "SPD", "OCD", "NOD", "VG", "UVG", "DVG", "TVG", "QAVG", "QIVG", "SXVG", "SPVG", "OCVG"]

static func format_number(number : float, number_of_decimals : int = 1) -> String:
	#figure out how many decimal places to shift
	var power_of_1000 : float = MathUtils.log_with_base(number, 1000)
	#fix error when number is 0
	if is_equal_approx(number, 0.0): power_of_1000 = 0.0
	
	#round down to closest power of 1000
	var rounded_power_of_1000 : int = int(floorf(power_of_1000))
	#fix floating point precision rounding issue
	if is_equal_approx(power_of_1000, ceilf(power_of_1000)): rounded_power_of_1000 = int(ceilf(power_of_1000))
	
	#shift decimal to proper power of 1000
	var shifted_decimal : float = number / pow(1000, rounded_power_of_1000)
	
	#trim off extra decimals
	var string : String = String.num(shifted_decimal, number_of_decimals)
	#add monetary symbol
	string += NOTATION[rounded_power_of_1000]
	return string
