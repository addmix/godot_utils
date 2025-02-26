@tool
extends Node

# TODO: Find a fix to automatically deinit deleted instances
# TODO: Provide a "santize" feature, that removes deleted instances.

## TESTING[br]
## [br]
## [br]
## [br]
## [code]SettingsManager[/code] is a solution to update setting-dependent variables at runtime, avoiding the need to
## restart when any ProjectSettings are changed, and avoid unnecessary processing of variables that have not changed.[br]
## [br]
## Intended Usage:[br]
## [br]
## First, enable this singleton in project settings with by setting "godot_utils/settings_manager/enabled_settings_manager"
## to true.[br]
## [br]
## Add a line similar to this to any script that you would like to have updated settings: (static typing optional)[br]
## [code]var my_var : float = SettingsManager.register_setting(self, "my_setting/in/project_settings", func(x): my_var = x, 15.0)[/code][br]
## [br]
## [code]my_var[/code] will be initialized to the value of [code]"my_setting/in/project_settings"[/code] in ProjectSettings
## (if available), or the passed default value, in this case, [code]15.0[/code]
## [br]
## Then, you can change a setting with [code]SettingsManager.set_setting("my_setting/in/project_settings", 20.0)[/code],
## which will then change the value for all scripts that have called [code]SettingsManager.register_setting()[/code]
## for that setting.[br]
## [br]
## [code]SettingsManager.set_setting()[/code] does not automatically save values in ProjectSettings, so if you wish for settings
## to appear in ProjectSettings, be sure to call [code]ProjectSettings.save()[/code] (for editor builds), or
## [code]ProjectSettings.save_custom("override.cfg")[/code] (for exported builds).[br]
## [br]
## ProjectSettings changed outside of SettingsManager.set_setting() are not automatically replicated,
## so it is safe to change settings with ProjectSettings, but you must call [code]SettingsManager.set_setting()[/code]
## if you wish to update those settings at runtime.[br]



#used to check which objects are registered for the given setting
#{setting_name : {object : setter}}
## A dictionary containing mappings for all settings registered in the system.
var registered_settings : Dictionary = {}
#used to check which settings are registered for the given object
#{object : [setting : String, ...]}
## A dictionary containing mappings for all objects with their registered settings.
var registered_instances : Dictionary = {}

## Registers a setting to be updated by the [code]SettingsManager[/code] system.
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

## Removes all references to an object from the [code]registered_settings[/code] and [code]registered_instances[/code] lists.[br]
## This should be called in every participating script's deinit process, to avoid memory leaks. 
func unregister_instance(obj : Object) -> void:
	#remove instance from each setting
	for setting_name : String in registered_instances[obj]:
		registered_settings[setting_name].erase(obj)
	#remove instance
	registered_instances.erase(obj)

## Removes a settings from the [code]registered_settings[/code] list.
func unregister_setting(setting_name : String) -> void:
	#remove setting from all instances
	for obj : Object in registered_settings[setting_name].keys():
		registered_instances[obj].erase(setting_name)
	#remove setting
	registered_settings.erase(setting_name)

	# TODO:
	# If all settings are unregistered from an object, remove the object from registered_instances

## This is used to edit a setting in the ProjectSettings while taking advantage of the SettingsManager functionality. [br]
## This should be used instead of [code]ProjectSettings.set_setting()[/code]
func set_setting(setting_name : String, value : Variant) -> void:
	ProjectSettings.set_setting(setting_name, value)
	
	#update all registered settings
	for setter : Callable in registered_settings[setting_name].values():
		setter.call(value)
	
