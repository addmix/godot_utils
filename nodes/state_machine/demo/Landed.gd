extends State

@onready var player = $"../../"

# This state happens when you land after a jump.
# There is a slight delay after landing before you can move again.

func _enter(from : StringName) -> void:
	#after the player lands on the ground, disable movement
	player.movement_enabled = false

	#we put a cooldown after landing before the player can do anything
	await(get_tree().create_timer(0.2).timeout)

	#after the cooldown has finished, go back to the idle state.
	change_state("Idle")

func _physics_process(delta : float) -> void:
	#when the player's velocity is greater than 0, and not on the floor, we can
	#be sure they are falling, so we switch to the falling state.
	if player.velocity.y > 0.0 and !player.is_on_floor():
		change_state("Falling")