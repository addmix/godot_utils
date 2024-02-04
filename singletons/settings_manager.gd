extends Node

#used to check which objects are registered for the given setting
#{setting_name : {object : setter}}
var registered_settings : Dictionary = {}
#used to check which settings are registered for the given object
#{object : [setting : String, ...]}
var registered_instances : Dictionary = {}

func register_setting(obj : Object, setting_name : String, setter: Callable, default_value : Variant = null) -> Variant:
	#make sure setting is registered
	if not registered_settings.has(setting_name):
		registered_settings[setting_name] = {}
	
	#make sure object is registered for setting
	if not registered_settings[setting_name].has(obj):
		registered_settings[setting_name][obj] = setter
	
	#make sure object is registered
	if not registered_instances.has(obj):
		registered_instances[obj] = [setting_name]
	
	#make sure setting is registered for object
	if not registered_instances[obj].has(setting_name):
		registered_instances[obj].append(setting_name)
	
	#return value
	return SettingsUtils.ifndef(setting_name, default_value)

func unregister_instance(obj : Object) -> void:
	#remove instance from each setting
	for setting_name : String in registered_instances[obj]:
		registered_settings[setting_name].erase(obj)
	#remove instance
	registered_instances.erase(obj)

func unregister_setting(setting_name : String) -> void:
	#remove setting from all instances
	for obj : Object in registered_settings[setting_name].keys():
		registered_instances[obj].erase(setting_name)
	#remove setting
	registered_settings.erase(setting_name)

func set_setting(setting_name : String, value : Variant) -> void:
	ProjectSettings.set_setting(setting_name, value)
	
	#update all registered settings
	for setter : Callable in registered_settings[setting_name].values():
		setter.call(value)
