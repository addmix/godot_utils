# NodeUtils
## Functions
* `connect_signal_safe(node : Node, _signal : StringName, callable : Callable, flags : int = 0) -> int` Connects a signal while protecting from `"Signal already connected"` errors. Returns connection error (if any).

* `get_descendants(obj : Node) -> Array[Node]` Returns all descendants of specified node.
* `get_first_child_of_type(node : Node, type) -> Node` Finds the first child of given type.
* `get_first_descandant_of_type(node : Node, type, include_internal : bool = false) -> Node` Finds the first descendant of given type (depth-first).
* `get_descendants_of_type(node : Node, type, include_internal : bool = false) -> Array[Node]` Returns all descendants of specified type.
* `has_node_of_type(node : Node, type) -> bool` Checks if a descendant of a given type exists.

* `get_first_parent_of_type(node : Node, type) -> Node` Finds the first ancestor node of specified type.
* `get_first_parent_with_name(node : Node, _name : String) -> Node` Returns the first ancestor node with given name.
