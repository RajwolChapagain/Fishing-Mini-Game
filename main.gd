extends Node2D

func _on_level_cleared(level):
	if level == 1:
		$Panels.show_level_cleared_panel()
	elif level == 2:
		$Panels.show_congratulations_panel()

func _on_level_failed():
	$Panels.show_level_failed_panel()

func _on_panels_next_button_pressed():
	pass # Replace with function body.


func _on_panels_quit_button_pressed():
	pass # Replace with function body.


func _on_panels_restart_button_pressed():
	print("Restart the level")


func _on_panels_yay_button_pressed():
	pass # Replace with function body.
