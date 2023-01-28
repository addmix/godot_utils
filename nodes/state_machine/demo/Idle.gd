extends State

@onready var player = $"../../"


#in this state, you are not moving, jumping, falling or landed, you are sitting still


func _enter(from : StringName) -> void:
	player.movement_enabled = false

func _physics_process(delta: float) -> void:
	#when the player's velocity is greater than 0, and not on the floor, we can
	#be sure they are falling, so we switch to the falling state.
	if player.velocity.y > 0.0 and !player.is_on_floor():
		change_state("Falling")
	#if the player's input indicates a jump, and we are on the floor, we switch
	#to the jumping state.
	elif player.input.y < 0.0 and player.is_on_floor():
		change_state("Jumping")
	#if there is input, we know the player wants to move, so we switch to the
	#moving state.
	elif player.input.x != 0.0:
		change_state("Moving")

