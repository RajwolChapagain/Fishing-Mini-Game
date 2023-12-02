extends Node2D

func _ready():
	$Spawner.water_level = $Water.global_position.y - $Water.texture.get_height() / 2
	$Spawner.shore_line = $Shore.global_position.x - $Shore.texture.get_width() / 2
	
func on_fish_hooked(clicks):
	$Fisherman.increment_clicks_to_pull(clicks)

func on_fish_escaped(clicks):
	$Fisherman.decrement_clicks_to_pull(clicks)

func _on_spawner_fish_spawned(fish):
	fish.fish_hooked.connect(on_fish_hooked)
	fish.fish_escaped.connect(on_fish_escaped)
