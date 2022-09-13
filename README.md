# Godot Utils
A library of utility functions for the Godot game engine.

## Installation
1. Download and un-zip files.
2. The files can be placed anywhere inside your Godot project, but I suggest placing the entire `godot_utils` folder inside the `addons` folder.

## Usage

### Classes

Classes each have their own usage, but most are initialized using the `ClassName.new(...)` pattern. (ex. `PID.new(p_value, i_value, d_value)`)

### Global utilities

Globals are all declared as classes with static functions, and are declared automatically inside Godot, so you can reference the classes with their names just like any other built-in class. (ex. `FileUtils.get_files_in_directory("res://addons")` )

### Singletons

Singletons can be used selectively in a project, by adding them to the autoload list (`Project > Project Settings > Autoload`) and referenced using the autoload/singleton name assigned (Default naming scheme for singletons is the PascalCase conversion of the filename, ex. `PingService`)
