class_name PluginUtils

func check_dependencies() -> void:

	pass

static func get_plugin_list() -> Array:
	var plugins := []
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
				"path": path.get_base_dir()
			})

	return plugins

static func get_plugin_dictionary() -> Dictionary:
	var plugin_dictionary := {}
	
	var list := get_plugin_list()
	for plugin in list:
		plugin_dictionary[plugin["name"]] = plugin
	
	return plugin_dictionary

#very slow, use sparingly.
static func get_plugin_path(plugin : String) -> String:
	var dictionary := get_plugin_dictionary()
	if not dictionary.has(plugin):
		push_error("Plugin name not found in plugin dictionary.")
	return dictionary[plugin]["path"]

