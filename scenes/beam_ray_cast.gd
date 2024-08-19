extends RayCast2D

const DEFAULT_COLOR: Color = Color(255, 255, 255)
const ENLARGER_COLOR: Color = Color(255, 0, 0)
const REDUCER_COLOR: Color = Color(0, 0, 255)

var beam_color: Color = DEFAULT_COLOR

var is_casting: bool = false :
	set(value): 
		is_casting = value
		
		if is_casting:
			appear()
		else:
			disapear()
		set_physics_process(is_casting)


func _ready():
	is_casting = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("enlarger_shot"):
		self.beam_color = ENLARGER_COLOR
		self.is_casting = true
	elif event.is_action_pressed("reducer_shot"):
		self.beam_color = REDUCER_COLOR
		self.is_casting = true
	elif event.is_action_released("enlarger_shot") or event.is_action_released("reducer_shot"):
		self.is_casting = false
		self.target_position = Vector2(0.0, 0.0)
		self.beam_color = DEFAULT_COLOR


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
		self.target_position = cast_point
		
	%BeamLine.points[1] = cast_point


func appear() -> void:
	%BeamLine.default_color = beam_color
	%BeamLine.width = 3.0


func disapear() -> void:
	%BeamLine.width = 0
