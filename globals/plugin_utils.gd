class_name PluginUtils

func check_dependencies() -> void:

	pass

func get_plugin_list() -> Array:
	var plugins := []

	print(DirAccess.get_directories_at("res://addons"))

	for directory in DirAccess.get_directories_at("res://addons"):
		var path := "res://addons/%s/plugin.cfg" % directory
		if FileAccess.file_exists(path):
			var config := ConfigFile.new()
			var err := config.load(path)

			plugins.append({
				"name": config.get_value("plugin", "name", ""),
				"description": config.get_value("plugin", "description", ""),
				"author": config.get_value("plugin", "author", ""),
				"version": config.get_value("plugin", "version", ""),
				"script": config.get_value("plugin", "script", ""),
				"path": path
			})

	return plugins



