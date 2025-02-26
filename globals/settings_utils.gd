class_name SettingsUtils

## Returns the given ProjectSetting. If the ProjectSetting is not declared, a default value will be added to the project settings, and the default value is returned.
# TODO: Make an EditorSetting counterpart.
static func ifndef(setting : String, default_value : Variant) -> Variant:
	if not ProjectSettings.has_setting(setting):
		ProjectSettings.set_setting(setting, default_value)
		if not default_value == null:
			ProjectSettings.set_initial_value(setting, default_value)
	# TODO: Should the projectsettings be saved here?

	return ProjectSettings.get_setting(setting)
