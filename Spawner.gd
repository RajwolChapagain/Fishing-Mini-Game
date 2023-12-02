extends Timer

@export var fishes : Array[PackedScene]
@export var big_fish_scene : PackedScene

var water_level
var shore_line

signal fish_spawned(fish)

func _on_timeout():
	if fishes.size() != 0:
		spawn_fish_at_random_position(fishes.pick_random().instantiate())

func spawn_big_fish():
	stop()
	spawn_fish_at_random_position(big_fish_scene.instantiate())
	
func spawn_fish_at_random_position(fish):
	$Path2D/PathFollow2D.progress_ratio = randf()
	fish.global_position = $Path2D/PathFollow2D.global_position
	fish.set_water_level(water_level)
	fish.set_shore_line(shore_line)
	add_child(fish)
	fish_spawned.emit(fish)
