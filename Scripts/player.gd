extends CharacterBody2D

@export var move_speed : float = 300
@export var acceleration : float = 50
@export var braking : float = 20
@export var jump_height : float = 100

var move_input
var gravity_flipped : bool = false

func _physics_process(delta: float) -> void:

	move_input = Input.get_axis("move_left", "move_right")

	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)

	move_and_slide()
