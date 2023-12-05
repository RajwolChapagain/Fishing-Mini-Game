extends Node2D

@export var levels : Array[PackedScene]
@export var title_screen_scene = preload("res://ui/title_screen.tscn")
	
func _ready():
	take_to_title_screen()
	
func _on_level_cleared(level):
	$LevelClearedSound.play()
	if level == 1:
		$Panels.show_level_cleared_panel()
	elif level == 2:
		$Panels.show_congratulations_panel()

func _on_level_failed():
	$Panels.show_level_failed_panel()

func _on_panels_next_button_pressed():
	$Panels.hide_level_cleared_panel()
	for child in get_children():
		if child.is_in_group("level"):
			child.queue_free()
			
	instantitate_level_and_connect_signals(2)

func _on_panels_quit_button_pressed():
	$Panels.hide_level_failed_panel()
	take_to_title_screen()

func _on_panels_restart_button_pressed():
	$Panels.hide_level_failed_panel()
	for child in get_children():
		if child.is_in_group("level"):
			child.queue_free()
			instantitate_level_and_connect_signals(child.level)

func _on_panels_yay_button_pressed():
	$Panels.hide_congratulations_panel()
	take_to_title_screen()
	
func instantitate_level_and_connect_signals(level):
	var current_level = levels[level-1].instantiate()
	add_child(current_level)
	current_level.level_cleared.connect(_on_level_cleared)
	current_level.level_failed.connect(_on_level_failed)
	move_child(current_level, 0)
	
func take_to_title_screen():
	for child in get_children():
		if child.is_in_group("level"):
			child.queue_free()
	
	var title_screen = title_screen_scene.instantiate()
	add_child(title_screen)
	title_screen.size = get_viewport_rect().size
	title_screen.get_node("PlayButton").button_up.connect(on_play_button_pressed)
	
func on_play_button_pressed():
	get_node("TitleScreen").queue_free()
	instantitate_level_and_connect_signals(1)
