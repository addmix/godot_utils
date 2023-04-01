# StateMachine
## Variables
* `states : Dictionary` Contains references to all the states. Format {StringName state_name : state}
* `current_state : StringName` The current state of this state machine.

## Functions
* `change_state(new_state : StringName) -> void` Changes the state. Can be called externally.
