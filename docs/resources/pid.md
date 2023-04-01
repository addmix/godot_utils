# PID
## Variables
* `p : float = 0.2` proportional constant
* `i : float = 0.2` integral constant
* `d : float = 0.2` derivative constant

* `output : float = 0.0` output value of the PID resource.

## Functions
* `update(delta : float, error : float) -> float` Updates the PID controller. Error is the difference between a value's current value, and the desired value.

## Usage
