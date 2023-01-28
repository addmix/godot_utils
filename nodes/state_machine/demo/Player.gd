extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var input := Vector2.ZERO
var movement_enabled := false

func _physics_process(delta: float) -> void:
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if movement_enabled:
		velocity.x = input.x * SPEED
	elif is_on_floor():
		velocity.x = 0.0

	if !is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
