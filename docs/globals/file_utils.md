# FileUtils

## Functions
* `get_files_in_directory(path : String) -> PackedStringArray` Returns a PackedStringArray containing the filenames of all files in the supplied directory path.
* `find_files_of_type(path : String, type : String) -> PackedStringArray` Returns a PackedStringArray containing the filenames of all files matching the file type extension supplied in `type`.
* `find_file_of_type(path : String, type : String) -> String` Returns the filename of the first file with the given file type extension supplied in `type`.
* `load_dictionary_from_config_file(path : String) -> Dictionary` Loads a config file, and places key value pairs into a dictionary. See `save_dictionary_as_config_file()`.
* `save_dictionary_as_config_file(path : String, value : Dictionary) -> void` Saves dictionary as a config file. See `load_dictionary_from_config_file()`.
