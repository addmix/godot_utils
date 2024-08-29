extends Node
class_name UnitUtils
## Class for converting units.[br]
## Standard units: Meters, Seconds, Kilograms.
##
## Intended usage example:[br]
## [br]
## meters to yards: [code]UnitUtils.convert_meters_to(1.0, UnitUtils.Conversions.yards)[/code][br]
## meters/second to meters/hour: [code]UnitUtils.convert_meters_to(1.0, UnitUtils.Conversions.no_change, UnitUtils.Conversions.hours)[/code][br]
## meters/second to miles/hour: [code]UnitUtils.convert_meters_to(100.0, UnitUtils.Conversions.miles, UnitUtils.Conversions.hour)[/code][br]
## [br]
## Weight:[br]
## kilograms to pounds: [code]UnitUtils.convert_standard_to(2, UnitUtils.Conversions.pound)[/code][br]
## [br]
## Special conversion:[br]
## m/s to knots: [code]UnitUtils.convert_meters_to(100.0, UnitUtils.Conversions.knots)[/code][br]
## m/s^2 to gravity: [code]UnitUtils.convert_meters_to(9.81, UnitUtils.Conversions.gravity)[/code][br]
## m/s^2 to ft/s^2: [code]UnitUtils.convert_meters_to(1.0, UnitUtils.Conversions.feet)[/code][br]


#conversion factors for converting meters to other units.
const Conversions = {
	"no_change" : 1.0,
	
	#distance
	"millimeters" : 1000.0,
	"centimeters" : 100.0,
	"decimeters" : 10.0,
	"meters" : 1.0,
	"decameters" : 0.1,
	"hectometers" : 0.01,
	"kilometers" : 0.001,
	"inches" : 39.3700787402,
	"feet" : 3.2808398950131,
	"yards" : 1.0936132983,
	"miles" : 6.2137119223733e-4,
	"nautical_mile" : 5.3995680345572e-4,
	"astronomical_unit" : 6.6845871226706e-12,
	"lightyear" : 1 / 9.4607379375591e+15,
	
	#time
	"millisecond" : 1000.0,
	"second" : 1.0,
	"minute" : 1.0 / 60.0,
	"hour" : 1.0 / 3600.0,
	"day" : 1 / 86400.0,
	"week" : 1 / 604800.0,
	"month" : 3.8051750380518e-7,
	"year" : 3.168753601134e-8,
	"decade" : 3.168753601134e-8 / 10.0, 
	"century" : 3.168753601134e-8 / 100.0, 
	"millenia" : 3.168753601134e-8 / 1000.0,
	
	#speed-specific
	"knots" : 1.9438444924406,
	
	#acceleration
	"gravity" : 0.10197162129779,
	
	#mass
	"milligrams" : 1000000.0,
	"grams" : 1000.0,
	"kilograms" : 1.0,
	"metric_ton" : 0.001,
	"ounce" : 	35.27396194958,
	"pound" : 2.2046226218488,
}


static func convert_standard_to(value : float, distance_unit : float = 1.0, time_unit : float = 1.0) -> float:
	return value * (distance_unit / time_unit)

static func convert_to_standard(value : float, distance_unit : float = 1.0, time_unit : float = 1.0) -> float:
	return value / (distance_unit / time_unit)

static func convert_units(value : float, from_distance_unit : float = 1.0, from_time_unit : float = 1.0, to_distance_unit : float = 1.0, to_time_unit : float = 1.0) -> float:
	return convert_standard_to(convert_to_standard(value, from_distance_unit, from_time_unit), to_distance_unit, to_time_unit)
