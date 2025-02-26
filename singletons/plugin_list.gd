extends Node

## Provides a cached plugin list, using the [code]PluginUtils[/code] functions.

## A dictionary containing the information from all detected plugins [code]plugin.cfg[/code] files.
var plugins : Dictionary = {}

func _ready() -> void:
	update_list()

## When called, the [code]res://addons[/code] folder is scanned, and plugin data is loaded from their [code]plugin.cfg[/code] files.
func update_list() -> void:
	plugins = PluginUtils.get_plugin_dictionary()

## Returns the cached filepath of the given plugin, identified by name.
func get_cached_plugin_path(plugin : String) -> String:
	if not plugins.has(plugin):
		push_error("Plugin name not found in plugin dictionary.")
	return plugins.get(plugin, {}).get("path", "")
