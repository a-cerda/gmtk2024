extends CharacterBody2D

@export var SPEED: float = 350.0
@export var GRAVITY: float = 700.0
@export var JUMP_SPEED: float = 280.0
@export var DRAG: float = 10.0

func _physics_process(delta: float) -> void:	
	# if is_in_air: velocity * delta
	# in ground: inmediate velocity
	if is_on_floor():
		if Input.is_action_pressed("left"):
			velocity.x = -SPEED
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED
		else:
			velocity.x = velocity.x - velocity.x * delta * DRAG
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMP_SPEED
	else:
		if Input.is_action_pressed("left"):
			velocity.x += delta * -SPEED
		elif Input.is_action_pressed("right"):
			velocity.x += delta * SPEED
		velocity.y += delta * GRAVITY
	move_and_slide()