extends State

@onready var player = $"../../"

func _enter(from : StringName) -> void:
	player.movement_enabled = false

func _physics_process(delta: float) -> void:
	#if the player is on the floor, we know that they just landed on the ground.
	if player.is_on_floor():
		change_state("Landed")
