extends Control

@export var button_normal : Texture2D
@export var button_hovered : Texture2D
@export var button_pressed : Texture2D

func _ready():
	$PlayButton/AnimationPlayer.play("bob")
	
func _on_play_button_mouse_entered():
	$PlayButton.icon = button_hovered

func _on_play_button_mouse_exited():
	$PlayButton.icon = button_normal

func _on_play_button_button_down():
	$PlayButton.icon = button_pressed
