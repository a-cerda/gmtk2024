extends AnimatableBody2D

var growing = false
var shrinking = false
const MAX_SIZE = Vector2(300, 300)

func grow():
	var overlaps = %DetectionArea.get_overlapping_bodies()
	var hits_terrain: bool = false
	for body in overlaps:
		if body is TileMapLayer:
			hits_terrain = true
	if not hits_terrain:
		#get_tree().get_first_node_in_group("Colliders")
		transform = transform.scaled_local(Vector2(1.05, 1.05))
		growing = true
	
func shrink():
	transform = transform.scaled_local(Vector2(0.95, 0.95))
	shrinking = true


func _on_detection_area_body_entered(body: Node2D) -> void:
	pass 
	#if body.has_method("respawn"):
		#body.apply_floor_snap()
		#if body.global_position.y + body.transfo > self.global_position.y:
			#body.global_position.y += self.position.y
