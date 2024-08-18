extends CharacterBody2D

@export var SPEED: float = 400.0
@export var GRAVITY: float = 300.0

func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("left", "right")
	velocity.x = direction * SPEED
	velocity.y += delta * GRAVITY
	move_and_slide()
