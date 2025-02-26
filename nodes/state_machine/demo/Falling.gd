extends State

@onready var player = $"../../"

# we disable movement input when falling
# when we detect the player is on the ground again, we transfer to the landed state.

func _enter(from : StringName) -> void:
	#we don't want the player to be able to change their movement speed while falling, so we disable movement on the player.
	player.movement_enabled = false

func _physics_process(delta: float) -> void:
	#if the player is on the floor, we know that they just landed on the ground, so we will change to the landed state.
	if player.is_on_floor():
		change_state("Landed")
