class_name ResourceUpdater

var updated_properties : Dictionary

#object is the node/resource that is being converted/updated. This is necessary for the update logic functions
func _init(object : Object) -> void:
	updated_properties = get_property_conversion_info(object)

#virtual function

func get_property_conversion_info(object : Object) -> Dictionary:
	#return super.get_property_conversion_info(object).merged({
	return {
	
	#example of a property to update:
	
	
	#"throttle_input": [TYPE_FLOAT, \
	#func(value) -> void:
		#throttle_control_config.input = value
	#],
	
	
	#"throttle_input" is the property name, as stored in the resource file (old variable name)
	#TYPE_FLOAT is the type of property (float, bool, Vector3, etc.)
	#func(value) -> void is a function which contains the logic to convert the old property into some new format
	
	}
	#)

#this function needs to be called in the object's _get_property_list() function
func _get_property_list() -> Array[Dictionary]:
	var array : Array[Dictionary] = []
	
	for property in updated_properties.keys():
		var property_info : Array = updated_properties[property]
		array.append({
			"name" : property,
			"type" : property_info[0],
			"usage" : 0,
		})
	
	return array

#this function needs to be called in the object's _set() function
func _set(property: StringName, value: Variant) -> bool:
	if property in updated_properties.keys():
		var property_info : Array = updated_properties[property]
		if property_info.size() >= 2:
			property_info[1].call(value)
		
		return true
	return false
