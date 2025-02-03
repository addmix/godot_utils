extends Node

var args : Dictionary = {}
#format: 
#argument string = "variable_name=value level=5 health=65.2"
#{
#	"variable_name" : value,
#	"level" : int(5),
#	"health" : float(65.2),
#}

func _ready() -> void:
	args = parse_cmdline_args(OS.get_cmdline_args())

func parse_cmdline_args(args : PackedStringArray) -> Dictionary:
	var parsed_args : Dictionary = {}
	
	for arg : String in args:
		#check if argument is an assignment
		if arg.match("*=*"):
			var argument_sections : PackedStringArray = arg.split("=")
			if argument_sections.size() == 0:
				#no valid args
				continue
			
			if argument_sections.size() == 2:
				#no proper assignment
				parsed_args[argument_sections[0]] = str_to_var(argument_sections[1])
				continue
		else:
			parsed_args[arg] = true # default to true, to signal that this argument was passed.
	
	return parsed_args

func has_arg(arg : String) -> bool:
	return args.keys().has(arg)

func get_arg_value_or_null(arg : String) -> Variant:
	if not has_arg(arg):
		return null
	
	return args[arg]

func ifndef(arg : String, default : Variant) -> Variant:
	if has_arg(arg):
		return args[arg]
	
	return default
