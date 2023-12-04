extends Node2D

@export var levels : Array[PackedScene]

func _ready():
	instantitate_level_and_connect_signals(1)
	pass
	
func _input(event):
	if event.is_action_pressed("fail_level"):
		_on_level_failed()
		
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
	for child in get_children():
		if child.is_in_group("level"):
			child.queue_free()
			instantitate_level_and_connect_signals(child.level)

func _on_panels_yay_button_pressed():
	pass # Replace with function body.

func instantitate_level_and_connect_signals(level):
	var current_level = levels[level-1].instantiate()
	add_child(current_level)
	current_level.level_cleared.connect(_on_level_cleared)
	current_level.level_failed.connect(_on_level_failed)
	move_child(current_level, 0)
	
