# TimeMachcine
## Variables
* `max_time_machine_entries : int = 30` The maximum amount of time machine entries that are kept at a time.

## Functions
* `get_interpolated_property(object : Object, property : String, seconds_in_past : float) -> Variant` Returns the interpolated value that `object`'s `property` was at `seconds_in_past`.
* `get_property(object : Object, property : String, seconds_in_past : float) -> Variant` Returns the value that `object`'s `property` was at `seconds_in_past`. For use with datatypes that cannot be interpolated.
* `register_object(object : Object) -> void` Adds a time machine entry for `object`. Must be done every frame.
* `set_property(object : Object, property : String, value : Variant) -> void` Adds the value of `property` to `object`'s current time machine entry.

## Usage
