extends CharacterBody2D

@export var move_speed : float = 500
@export var jump_height : float = 100

var move_input
var gravity_flipped : bool = false

func _physics_process(delta: float) -> void:
	pass
