extends State

@onready var player = $"../../"

func _enter(from : StringName) -> void:
	#we allow the player to change their movement while jumping, in case they change their mind.
	player.movement_enabled = true
	player.jump()

func _physics_process(delta: float) -> void:
	#when the player's velocity is greater than 0, and not on the floor, we can
	#be sure they are falling, so we switch to the falling state.
	if player.velocity.y > 0.0 and !player.is_on_floor():
		change_state("Falling")
