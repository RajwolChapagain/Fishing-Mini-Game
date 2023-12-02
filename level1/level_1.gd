extends Node2D

@export var small_fish_to_catch = 5
@export var medium_fish_to_catch = 5

func _ready():
	$Spawner.water_level = $Water.global_position.y - $Water.texture.get_height() / 2
	$Spawner.shore_line = $Shore.global_position.x - $Shore.texture.get_width() / 2
	$HUD.set_num_small_fish_to_catch(small_fish_to_catch)
	$HUD.set_num_medium_fish_to_catch(medium_fish_to_catch)
	
func on_fish_hooked(clicks):
	$Fisherman.increment_clicks_to_pull(clicks)

func on_fish_escaped(clicks):
	$Fisherman.decrement_clicks_to_pull(clicks)

func _on_spawner_fish_spawned(fish):
	fish.fish_hooked.connect(on_fish_hooked)
	fish.fish_escaped.connect(on_fish_escaped)

func _on_fisherman_caught_small_fish(small_fish_count):
	$HUD.set_num_small_fish_caught(small_fish_count)

func _on_fisherman_caught_medium_fish(medium_fish_count):
	$HUD.set_num_medium_fish_caught(medium_fish_count)

func _on_fisherman_caught_large_fish():
	print("Level cleared")

func _on_fisherman_clicks_to_pull_changed(clicks_to_pull):
	$HUD.set_clicks_to_catch(clicks_to_pull)
