# UnitUtils
Utilities for converting different units.

## Functions
### Speed conversions
* `meters_per_second_to_feet_per_second(ms : float) -> float` Converts meters per second (`mps`, `m/s`) to feet per second (`fps`, `ft/s`).
* `meters_per_second_to_knots(ms : float) -> float` Converts meters per second to knots (nautical miles per hour).
* `meters_per_second_to_miles_per_hour(ms : float) -> float` Converts meters per second to miles per hour (`mph`).
* `meters_per_second_to_kilometers_per_hour(ms : float) -> float` Converts meters per second to kilometers per hour (`kph`, `km/h`).

### Distance conversions
* `meters_to_feet(m : float) -> float` Converts meters (`m`) to feet (`ft`).
* `meters_to_kilometers(m : float) -> float` Converts meters to kilometers (`km`).
* `meters_to_miles(m : float) -> float` Converts meters to miles ('mi').

### Acceleration conversions
* `meters_per_second_squared_to_gs(ms2 : float) -> float` Converts meters per second squared (`m/s^2`) to G force (`G`).
* `meters_per_second_squared_to_feet_per_second_squared(ms2 : float) -> float` Converts meters per second squared to feet per second squared (`ft/s^2`).