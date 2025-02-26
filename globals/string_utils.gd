class_name StringUtils

const NOTATION : Array = ["", "K", "M", "B", "T", "QA", "QI", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD", "QAD", "QID", "SXD", "SPD", "OCD", "NOD", "VG", "UVG", "DVG", "TVG", "QAVG", "QIVG", "SXVG", "SPVG", "OCVG"]

## Formats a float as a large number. [br]
## [br]
## Example: [code]format_number(1234567.89, 2) == "1.234M"[/code]
# TODO: Change behavior so that total number of digits is considered instead of the number of decimals.
# TODO: Allow for usage of different number notations
# TODO: Allow for usage of different number bases
# TODO: Allow for fractional notation (centi, milli, etc)
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

## Formats a float as time. [br]
## [br]
## Example: [code]format_time(123.45) == "02:03:45"[/code]
## Example: [code]format_time(12345) == "03:25:45:00"[/code]
# TODO: Extend so that days, months, and years might be used.
# TODO: Provide options to omit milliseconds.
static func format_time(time : float, delimiter : String = ":") -> String:
	var time_left : float = time
	var end_string : String = ""
	
	#hours
	var hours : float = UnitUtils.convert_standard_to(time_left, UnitUtils.Conversions.hour)
	hours = floorf(hours)
	time_left -= UnitUtils.convert_to_standard(hours, UnitUtils.Conversions.hour)
	if hours > 0.0 or not end_string == "":
		end_string += String.num(hours, 0) + delimiter
	
	# TODO: fix usage of pad_zeros() so that the leading number does not pad.
	#minutes
	var minutes : float = UnitUtils.convert_standard_to(time_left, UnitUtils.Conversions.minute)
	minutes = floorf(minutes)
	time_left -= UnitUtils.convert_to_standard(minutes, UnitUtils.Conversions.minute)
	#if minutes > 0.0 or not end_string == "":
	end_string += String.num(minutes, 0).pad_zeros(2) + delimiter
	
	#seconds
	#no conv
	var seconds : float = floorf(time_left)
	time_left -= seconds
	#if seconds > 0.0 or not end_string == "":
	end_string += String.num(seconds, 0).pad_zeros(2) + delimiter
	
	#milliseconds
	var milli : float = UnitUtils.convert_standard_to(time_left, UnitUtils.Conversions.millisecond)
	milli = floorf(milli)
	#if milli > 0.0 or not end_string == "":
	end_string += String.num(milli, 0).pad_zeros(3).left(2)
	
	return end_string
