extends AnimatableBody2D


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("down"):
		shrink()
	elif Input.is_action_pressed("up"):
		grow()

func grow():
	transform = transform.scaled_local(Vector2(1.05, 1.05))
	
func shrink():
	transform = transform.scaled_local(Vector2(0.95, 0.95))
