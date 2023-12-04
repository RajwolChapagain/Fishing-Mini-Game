extends Node2D

func _on_level_cleared(level):
	if level == 1:
		$Panels.show_level_cleared_panel()
	elif level == 2:
		$Panels.show_congratulations_panel()

func _on_level_failed():
	$Panels.show_level_failed_panel()
