extends Node

var plugins : Dictionary = {}

func _ready() -> void:
	update_list()

func update_list() -> void:
	plugins = PluginUtils.get_plugin_dictionary()

func get_cached_plugin_path(plugin : String) -> String:
	if not plugins.has(plugin):
		push_error("Plugin name not found in plugin dictionary.")
	return plugins[plugin]["path"]
