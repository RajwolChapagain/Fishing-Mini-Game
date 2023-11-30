extends Sprite2D

var water_level = global_position.y
var is_thrown = false

func _input(event):
	if event.is_action_pressed("throw_line"):
		if is_thrown:
			pull_fishing_line()
		else:
			throw_fishing_line(get_global_mouse_position())
	
func throw_fishing_line(pos):
	if pos.x < $Marker2D.global_position.x and pos.y > water_level:
		$Bobber.global_position = pos
		is_thrown = true

func pull_fishing_line():
	$Bobber.position = $Marker2D.position
	is_thrown = false
