# PluginUtils
## Functions
* `get_plugin_list() -> Array` Returns a list of all plugins found in the `addons` folder. Does not contain plugin enabled status. Currently does not cache plugin list, meaning it will be very slow, loading all plugin.cfg files.
* `get_plugin_dictionary() -> Dictionary` Formats the result of `get_plugin_list()` into a dictionary with the plugin name as the key, and the plugin data array as the value. Currently does not cache plugin list, meaning it will be very slow, loading all plugin.cfg files.
* `get_plugin_path(plugin_name : String) -> String` Returns the filepath for the plugin with the given name. Currently does not cache plugin list, meaning it will be very slow, loading all plugin.cfg files.