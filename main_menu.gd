extends Control




func _on_play_pressed() -> void:
	#TODO: Cambiar a la escena final esta función cuando se haya decidido
	get_tree().change_scene_to_file("res://levels/level_0.tscn")



func _on_level_selector_pressed() -> void:
	pass # Replace with function body.



func _on_exit_pressed() -> void:
	get_tree().quit()
