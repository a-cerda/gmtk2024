extends RayCast2D

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
	if event is InputEventMouseButton:
		self.is_casting = event.pressed

func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	%BeamLine.points[1] = cast_point


func appear() -> void:
	var tween = create_tween()
	tween.tween_property(%BeamLine, "width", 3.0, 0.2)


func disapear() -> void:
	var tween = create_tween()
	tween.tween_property(%BeamLine, "width", 0, 0.1)
