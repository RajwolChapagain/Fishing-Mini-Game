extends Sprite2D

func _input(event):
	if event.is_action_pressed("throw_line"):
		throw_fishing_line()
	
func throw_fishing_line():
	print("fishing line thrown")
