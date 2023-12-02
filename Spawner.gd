extends Timer

@export var fishes : Array[PackedScene]
@export var big_fish_scene : PackedScene


func _on_timeout():
	if fishes.size() != 0:
		var fish = fishes[0].instantiate()
		
		$Path2D/PathFollow2D.progress_ratio = randf()
		fish.global_position = $Path2D/PathFollow2D.global_position
		add_child(fish)
