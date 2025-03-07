extends RayCast2D

const DEFAULT_COLOR: Color = Color(255, 255, 255)
const ENLARGER_COLOR: Color = Color(255, 0, 0)
const REDUCER_COLOR: Color = Color(0, 0, 255)

var beam_color: Color = DEFAULT_COLOR
var GROW_OR_SHRINK: int = 0
@onready var RAY: AudioStreamPlayer2D = $Ray
@onready var GROW: AudioStreamPlayer2D = $Grow
@onready var SHRINK: AudioStreamPlayer2D = $Shrink
var vol = 7.0

func _ready() -> void:
	RAY.volume_db -= vol
	GROW.volume_db -= vol
	SHRINK.volume_db -= vol
	is_casting = false

var is_casting: bool = false :
	set(value): 
		is_casting = value
		if is_casting:
			RAY.play()
			appear()
		else:
			RAY.stop()
			disapear()
			GROW.stop()
			SHRINK.stop()
		set_physics_process(is_casting)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enlarger_shot"):
		self.beam_color = ENLARGER_COLOR
		self.is_casting = true
		self.GROW_OR_SHRINK = 1
	elif event.is_action_pressed("reducer_shot"):
		self.beam_color = REDUCER_COLOR
		self.is_casting = true
		self.GROW_OR_SHRINK = 2
	elif event.is_action_released("enlarger_shot") or event.is_action_released("reducer_shot"):
		self.is_casting = false
		self.target_position = Vector2(0.0, 0.0)
		self.beam_color = DEFAULT_COLOR
		self.GROW_OR_SHRINK = 0


func _physics_process(delta: float) -> void:
	# Max length of the beam raycast 
	var max_beam_length = get_viewport().size.length() * 0.75
	# If the player is shooting (or is casting) and the length is not the larger it can be
	# make it grow!
	if self.is_casting and self.target_position.length() <= max_beam_length and not is_colliding():
		self.target_position += Vector2(delta * 5000.0, 0) # 5k 
	var cast_point := target_position

	force_raycast_update()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		# Only to update raycast length
		self.target_position = cast_point
		var colliding_body = self.get_collider()
		if colliding_body.has_method("grow"):
			if GROW_OR_SHRINK == 1:
				if not GROW.playing:
					GROW.play()
				colliding_body.grow()
				if GROW.get_playback_position() > 2.11:
					GROW.stop()
			elif GROW_OR_SHRINK == 2:
				if not SHRINK.playing:
					SHRINK.play()
				colliding_body.shrink()
				if SHRINK.get_playback_position() > 1.16:
					SHRINK.stop()
		else:
			GROW.stop()
			SHRINK.stop()
			
		
	%BeamLine.points[1] = cast_point


func appear() -> void:
	%BeamLine.default_color = beam_color
	%BeamLine.width = 3.0


func disapear() -> void:
	%BeamLine.width = 0
