@tool
extends Node



# Intended Usage:
#
# First, enable this singleton in project settings with by setting "godot_utils/settings_manager/enabled_settings_manager"
# to true.
#
# Add a line similar to this to any script that you would like to have updated settings: (static typing optional)
# var my_var : float = SettingsManager.register_setting(self, "my_setting/in/project_settings", func(x): my_var = x, 15.0)
#
# my_var will be initialized to the value of "my_setting/in/project_settings" in ProjectSettings
# (if available), or the passed default value, in this case, 15.0
#
# Then, you can change a setting with SettingsManager.set_setting("my_setting/in/project_settings", 20.0)
# which will then change the value for all scripts that have called SettingsManager.register_setting
# for that setting.
#
# SettingsManager.set_setting() does not save values in ProjectSettings, so if you wish for settings
# to appear in ProjectSettings, be sure to call ProjectSettings.save() (for in-editor), or
# ProjectSettings.save_custom("override.cfg") (for in-game)
#
# ProjectSettings changed outside of SettingsManager.set_setting() are not automatically replicated,
# so it is safe to change settings with ProjectSettings, but you must call SettingsManager.set_setting()
# if you wish to update those settings at runtime.



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
	
