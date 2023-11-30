extends Sprite2D

var water_level = global_position.y

func _input(event):
	if event.is_action_pressed("throw_line"):
		throw_fishing_line(get_global_mouse_position())
	
func throw_fishing_line(pos):
	if pos.x < $Marker2D.global_position.x and pos.y > water_level:
		$Bobber.global_position = pos
