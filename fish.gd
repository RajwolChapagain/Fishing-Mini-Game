extends Area2D

@export var speed = 400

func move_to_pos(pos):
	var direction = global_position.direction_to(pos)
	
	while global_position.distance_to(pos) > 10:
		position += speed * direction * get_physics_process_delta_time()
		await get_tree().physics_frame
