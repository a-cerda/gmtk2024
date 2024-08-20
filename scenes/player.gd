extends CharacterBody2D

@export var SPEED: float = 350.0
@export var GRAVITY: float = 700.0
@export var JUMP_SPEED: float = 280.0
@export var DRAG: float = 10.0
@onready var PLAYER_SPAWN = self.position
@onready var STEP: AudioStreamPlayer2D = $Step
@onready var JUMP: AudioStreamPlayer2D = $Jump

func _ready() -> void:
	set_safe_margin(5)

func _physics_process(delta: float) -> void:
	# if is_in_air: velocity * delta
	# in ground: inmediate velocity
	if is_on_floor():
		if get_real_velocity() > Vector2(10,0) or get_real_velocity() < Vector2(-10, 0):
			if not STEP.playing:
				STEP.play()
		else: # we're standing
			STEP.stop()
		if Input.is_action_pressed("left"):
			velocity.x = -SPEED
			
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED
		else:
			velocity.x = velocity.x - velocity.x * delta * DRAG
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMP_SPEED
			JUMP.play()
	else:
		if Input.is_action_pressed("left"):
			velocity.x += delta * -SPEED
		elif Input.is_action_pressed("right"):
			velocity.x += delta * SPEED
		velocity.y += delta * GRAVITY
	move_and_slide()

	#if get_last_slide_collision():
		#print(get_last_slide_collision().get_collider())
	#if position.x > DisplayServer.screen_get_usable_rect().size.x or position.y > DisplayServer.screen_get_usable_rect().size.y:
		#respawn()


func respawn():
	position = PLAYER_SPAWN
