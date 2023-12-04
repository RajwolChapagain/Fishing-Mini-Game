extends Control

signal restart_button_pressed
signal next_button_pressed
signal yay_button_pressed
signal quit_button_pressed

func show_level_cleared_panel():
	$LevelClearedPanel.visible = true
	
func show_level_failed_panel():
	$LevelFailedPanel.visible = true

func show_congratulations_panel():
	$CongratulationsPanel.visible = true

func hide_level_cleared_panel():
	$LevelClearedPanel.visible = false
	
func hide_level_failed_panel():
	$LevelFailedPanel.visible = false
	
func hide_congratulations_panel():
	$CongratulationsPanel.visible = false

func _on_restart_button_button_up():
	restart_button_pressed.emit()

func _on_quit_button_button_up():
	quit_button_pressed.emit()

func _on_next_button_button_up():
	next_button_pressed.emit()

func _on_yay_button_button_up():
	yay_button_pressed.emit()
