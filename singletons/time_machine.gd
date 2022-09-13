extends Node

#30 entries, half a second
var max_time_machine_entries : int = 30

#might be slight issues with interpolations near recently (less than ping) spawned/destroyed objects

#first object in array (0) is oldest value
#last object in array is newest
var time_machine_dictionary : Dictionary = {
	#time : {
#		object : {
#			property : value
#		}
#	}
}

var current_time : int = Time.get_ticks_msec()

func _physics_process(delta : float) -> void:
	current_time = Time.get_ticks_msec()
	#add time machine entry for current time
	time_machine_dictionary[current_time] = {}
	
	#clear old time machine entries
	#Dictionary.keys() returns keys in order of most recently added
	if time_machine_dictionary.size() > max_time_machine_entries:
		time_machine_dictionary.erase(time_machine_dictionary.keys()[0])

#node property, interpolate
func get_interpolated_property(object : Object, property : String, seconds_in_past : float) -> Variant:
	#find 2 closest entries
	var time : int = current_time - int(seconds_in_past * 1000.0)
	
	#check out of bounds
	#too new
	if time > time_machine_dictionary.keys()[-1]:
		var key : int = time_machine_dictionary.keys()[-1]
		return time_machine_dictionary[key][object][property]
	#too old
	if time < time_machine_dictionary.keys()[0]:
		var key : int = time_machine_dictionary.keys()[0]
		return time_machine_dictionary[key][object][property]
	
	#will go from newest/largest to oldest/smallest
	for index in time_machine_dictionary.keys().size():
		var before : int = time_machine_dictionary.keys()[-index - 1]
		var after : int = time_machine_dictionary.keys()[-index]
		
		if before <= time and after > time:
#			print("time: %s, before: %s, after: %s" % [time, before, after])
			
			var interpolation_factor : float = remap(time, before, after, 0.0, 1.0)
			var before_value = time_machine_dictionary[before][object][property]
			var after_value = time_machine_dictionary[after][object][property]
			
			return lerp(before_value, after_value, interpolation_factor)
	
	var key : int = time_machine_dictionary.keys()[-1]
	return time_machine_dictionary[key][object][property]

#for use with datatypes that can't be interpolated
func get_property(object : Object, property : String, seconds_in_past : float) -> void:
	#find 2 closest entries
	var time : int = current_time - int(seconds_in_past * 1000.0)
	
	#check out of bounds
	#return closest value
	#too new
	if time > time_machine_dictionary.keys()[-1]:
		var key : int = time_machine_dictionary.keys()[-1]
		return time_machine_dictionary[key][object][property]
	#too old
	if time < time_machine_dictionary.keys()[0]:
		var key : int = time_machine_dictionary.keys()[0]
		return time_machine_dictionary[key][object][property]
	
	#will go from newest/largest to oldest/smallest
	#default to the lesser of the two values
	for index in time_machine_dictionary.keys().size():
		var before : int = time_machine_dictionary.keys()[-index - 1]
		var after : int = time_machine_dictionary.keys()[-index]
		
		if before < time and after > time:
			return time_machine_dictionary[after][object][property]

func register_object(object : Object) -> void:
	time_machine_dictionary[current_time][object] = {}

func set_property(object : Object, property : String, value : Variant) -> void:
	time_machine_dictionary[current_time][object][property] = value
