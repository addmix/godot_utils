class_name StringUtils

const MONETARY_NOTATION : Array = ['', 'K', 'M',' B','T','QA','QB','QC','QD','QE','QF','QG']

static func format_number(number : float, number_of_decimals : int = 1) -> String:
	#figure out how many decimal places to shift
	var power_of_1000 : float = MathUtils.log_with_base(number, 1000)
	
	#round down to closest power of 1000
	var rounded_power_of_1000 : int = int(floorf(power_of_1000))
	#fix floating point precision rounding issue
	if is_equal_approx(power_of_1000, ceilf(power_of_1000)): rounded_power_of_1000 = int(ceilf(power_of_1000))
	
	#shift decimal to proper power of 1000
	var shifted_decimal : float = number / pow(1000, rounded_power_of_1000)
	
	#trim off extra decimals
	var string : String = String.num(shifted_decimal, number_of_decimals)
	#add monetary symbol
	string += MONETARY_NOTATION[rounded_power_of_1000]
	return string
