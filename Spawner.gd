extends Timer

@export var fishes : Array[PackedScene]
@export var big_fish_scene : PackedScene

var water_level
var shore_line

func _on_timeout():
	if fishes.size() != 0:
		var fish = fishes[0].instantiate()
		
		$Path2D/PathFollow2D.progress_ratio = randf()
		fish.global_position = $Path2D/PathFollow2D.global_position
		fish.set_water_level(water_level)
		fish.set_shore_line(shore_line)
		add_child(fish)
