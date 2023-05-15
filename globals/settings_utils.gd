class_name SettingsUtils

static func ifndef(setting : String, default_value) -> Variant:
	if not ProjectSettings.has_setting(setting):
		ProjectSettings.set_setting(setting, default_value)
		ProjectSettings.set_initial_value(setting, default_value)

	return ProjectSettings.get_setting(setting)
