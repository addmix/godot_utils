# FloatingOrigin
## Signals
* `pre_origin_shift` Emitted immediately before an origin shift takes place.
* `origin_shifted` Emitted immediately after an origin shift.

## Variables
* `disabled : bool` If this node is disabled or not.
* `shift_threshold : float = 1024.0` The distance between origin shift steps.
* `shift_cooldown : float = 5.0` Minimum time between origin shifts.
* `current_offset : Vector3i` Current offset of `shift_threshold`
* `global_offset : Vector3` Global offset of this node.