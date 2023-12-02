extends Node2D

func _ready():
	$Spawner.water_level = $Water.global_position.y - $Water.texture.get_height() / 2
	$Spawner.shore_line = $Shore.global_position.x - $Shore.texture.get_width() / 2
