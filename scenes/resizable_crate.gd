extends AnimatableBody2D


func grow():
	var overlaps = %DetectionArea.get_overlapping_bodies()
	var hits_terrain: bool = false
	for body in overlaps:
		#print(body)
		if body is TileMapLayer:
			hits_terrain = true
	if not hits_terrain:
		transform = transform.scaled_local(Vector2(1.05, 1.05))
	
func shrink():
	transform = transform.scaled_local(Vector2(0.95, 0.95))
