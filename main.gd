extends Node2D

func _on_level_cleared(level):
	if level == 1:
		show_next_level_panel()
	elif level == 2:
		show_congratulations_panel()

func _on_level_failed():
	show_retry_panel()
	
func show_next_level_panel():
	print("Proceed to next level")

func show_congratulations_panel():
	print("You won the game!")

func show_retry_panel():
	print("Level failed! Retry")
