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
	else:
		self.is_casting = false
		self.beam_color = DEFAULT_COLOR


func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	%BeamLine.points[1] = cast_point


func appear() -> void:
	var tween = create_tween()
	tween.tween_property(%BeamLine, "default_color", beam_color, 0.2)
	tween.tween_property(%BeamLine, "width", 3.0, 0.2)


func disapear() -> void:
	var tween = create_tween()
	tween.tween_property(%BeamLine, "width", 0, 0.1)
