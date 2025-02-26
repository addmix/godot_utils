class_name InputUtils

## An alias for [code]Input.get_axis()[/code] that will not error or warn if either event is invalid.
func get_axis_safe(negative_event : StringName, positive_event : StringName) -> float:
	var input : float = 0.0
	
	if not negative_event == "":
		input -= Input.get_action_strength(negative_event)
	if not positive_event == "":
		input += Input.get_action_strength(positive_event)
	
	return input
