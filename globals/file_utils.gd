class_name FileUtils

## Helpful utilities for working with files. 

## Returns a PackedStringArray containing the names of all files and subdirectories in the specified directory.
static func get_files_in_directory(path : String) -> PackedStringArray:
	var files : PackedStringArray = PackedStringArray([])

	#initialize directory to path
	var dir := DirAccess.open(path)

	dir.set_include_hidden(true)
	dir.list_dir_begin()
	var val

	while(val != ""):
		#gets next file in directory
		val = dir.get_next()

		#empty string signifies end of directory
		if val == "":
			break

		files.append(val)

	dir.list_dir_end()
	return files


static func find_file_of_type(path : String, type : String) -> String:
	var dir := DirAccess.open(path)

	dir.set_include_hidden(true)
	dir.list_dir_begin()
	var val

	while(val != ""):
		#gets next file in directory
		val = dir.get_next()

		#empty string signifies end of directory
		if val == "":
			break

		var subs = val.split(".")

		#if file extension is of desired type
		if subs.size() >= 2:
			if subs[1] == type:
				dir.list_dir_end()
				return(path + "/" + val)

	return ""

static func find_files_of_type(path : String, type : String) -> PackedStringArray:
	var files : PackedStringArray = []

	var dir := DirAccess.open(path)

	dir.set_include_hidden(true)
	dir.list_dir_begin()
	var val

	while(val != ""):
		#gets next file in directory
		val = dir.get_next()

		#empty string signifies end of directory
		if val == "":
			break

		var subs = val.split(".")

		#if file extension is of desired type
		if subs[1] == type:
			files.append(path + "/" + val)

	dir.list_dir_end()
	return files

#loads config file as dictionary
static func load_dictionary_from_config_file(path : String) -> Dictionary:
	var file := ConfigFile.new()
	var err := file.load(path)
	if err == OK:

		#sections
		var sec := {}

		#add section subsection pairs to sec
		for section in file.get_sections():
			#subsections
			var subsec := {}

			#add key value pairs to subsec
			for key in file.get_section_keys(section):
				subsec[key] = file.get_value(section, key)

			#add subsec to sec
			sec[section] = subsec

		return sec

	#no file found
	elif err == ERR_FILE_NOT_FOUND:
		print("File not found at " + path + " creating new file")
		save_dictionary_as_config_file(path, {})
		return {}

	#error
	else:
		push_error("Error occured while loading file at " + path + " Error " + str(err))
		return {}

#saves dictionary as configfile
static func save_dictionary_as_config_file(path : String, value : Dictionary) -> void:
	var config := ConfigFile.new()

	#array section keys
	for section in value.keys():
		#dictionary key/value
		for key in value[section].keys():
			#values
			config.set_value(section, key, value[section][key])

	#save to file
	var err = config.save(path)
	#check save error
	if err != OK:
		push_error("Error " + err + " could not save " + path)
