extends State

@onready var player = $"../../"

func _enter(from : StringName) -> void:
	player.movement_enabled = false
	#when the player's velocity is greater than 0, and not on the floor, we can
	#be sure they are falling, so we switch to the falling state.
	if player.velocity.y > 0.0 and !player.is_on_floor():
		change_state("Falling")

	#we put a cooldown after landing before the player can do anything
	await(get_tree().create_timer(0.2).timeout)

	#if there is input, we know the player wants to move, so we switch to the
	#moving state.
	if player.input.x != 0.0:
		change_state("Moving")
	#otherwise, we know they are idle, so we can put them back in the idle state.
	else:
		change_state("Idle")
