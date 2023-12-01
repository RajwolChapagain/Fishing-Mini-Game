extends Node2D

@onready var water_level = $Water.global_position.y - $Water.texture.get_height() / 2
