# FloatingOriginHelper
## Variables
* `floating_origin : FloatingOrigin` Reference to the current (FloatingOrigin)[docs/nodes/3d/floating_origin.md] node.

## Functions
* `get_global_position(node : Node3D) -> Vector3` Returns the position of the given node adjusted for the current floating origin offset.
* `adjust_global_position(global_position : Vector3) -> Vector3` Returns the specified Vector3, with the global offset applied.
