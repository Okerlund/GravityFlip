extends CharacterBody2D

@export var move_speed : float = 300
@export var acceleration : float = 50
@export var braking : float = 20
@export var jump_force : float = 400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_input
var gravity_flipped : bool = false

@onready var sprite : Sprite2D = $Sprite
@onready var collision : CollisionShape2D = $CollisionShape2D

func _physics_process(delta: float) -> void:

	move_input = Input.get_axis("move_left", "move_right")

	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	
	if not gravity_flipped:
		velocity.y += gravity * delta
	else:
		velocity.y -= gravity * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	if Input.is_action_pressed("jump") and is_on_ceiling():
		velocity.y = jump_force

	if Input.is_action_just_pressed("flip_gravity") and not gravity_flipped and is_on_floor():
		sprite.flip_v = true
		collision.move_local_y(-28)
		gravity_flipped = true
	if Input.is_action_just_pressed("flip_gravity") and gravity_flipped and is_on_ceiling():
		sprite.flip_v = false
		collision.move_local_y(28)
		gravity_flipped = false

	move_and_slide()
