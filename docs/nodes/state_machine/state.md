# State

## Functions
* `change_state(new_state : StringName) -> void` Call to begin change to another state. States are identified by their node names.
* `virtual _process(delta : float) -> void` Can be overridden for custom behavior.
* `virtual _physics_process(delta : float) -> void` Can be overridden for custom behavior.
* `virtual _unhandled_input(event : InputEvent) -> void` Can be overridden for custom behavior.
* `virtual _enter(from : StringName) -> void` Can be overridden for custom behavior.
* `virtual _exit(to : StringName) -> void` Can be overridden for custom behavior.
