# MathUtils
## Constants
### `float` constants.
* `E = 2.718281828459045` Eulers number.

## Functions
### typle-less functions.
* `toggle(condition : bool, _true : Variant, _false : Variant) -> Variant` Branchless toggle function. Returns `_true` or `_false` depending on `condition` without branching. Both `_true` and `_false` must be of the same type, must be capable of summation, and must be capable of multiplying with `float`.

### `float` functions.
* `bias(x : float, bias : float) -> float` Biases the value `x` according to the bias factor `bias`.
* `float_toggle(condition : bool, _true : float, _false : float) -> float` Branchless toggle function for floats. Returns `_true` or `_false` depending on `condition` without branching. See `toggle()`
* `mix(a : float, b : float, amount : float) -> float` Mix operation.
* `move_to(position : float, target : float, speed : float = 1.0) -> float` Deprecated, use GDScript global `move_toward()` function instead. Moves `position` towards `target` by `speed` amount without overshoot.
* `polynomial_smin(a : float, b : float, k : float = 0.1) -> float` Performs the polynomial smooth minimum operation between `a` and `b` by factor `k`.
* `sigmoid(x : float, e : float = E) -> float` Sigmoid bias function.

### Matrix operations.
* `check_squareness(a : Array) -> void` Pushes an error if given matrix is not square.
* `identity_matrix(n : int) -> Array` Creates an identity matrix with side length of `n`.
* `inverse(a : Array) -> Array` Returns the inverse of the passed matrix.
* `multiply(a : Array, b : Array) -> Array` Multiplies the two passed matrices. Non-commutative.
* `zero_matrix(nX : int, nY : int) -> Array` Creates a matrix with dimensions `x, y` that is populated with the value 0.
