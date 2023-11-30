extends Area2D

@export var speed = 400
@export var move_radius = 400

func move_to_pos(pos):
	var direction = global_position.direction_to(pos)
	
	while global_position.distance_to(pos) > 10:
		position += speed * direction * get_physics_process_delta_time()
		await get_tree().physics_frame


func _on_vision_radius_area_entered(area):
	if area.name == "Bobber":
		print("Fish sees Bobber")
		move_to_pos(area.global_position)

func _on_move_timer_timeout():
	move_to_pos(global_position + Vector2(randi_range(-move_radius, move_radius), randi_range(-move_radius, move_radius)))
