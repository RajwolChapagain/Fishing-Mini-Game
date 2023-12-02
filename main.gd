extends Node2D

@onready var water_level = $Level1/Water.global_position.y - $Level1/Water.texture.get_height() / 2
