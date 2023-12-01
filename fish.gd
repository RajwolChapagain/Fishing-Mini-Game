extends Area2D

@export var speed = 400
@export var move_radius = 400

@onready var target = global_position

func _physics_process(_delta):
	move_to_target()
	
func move_to_target():
	var direction = global_position.direction_to(target)
	
	if global_position.distance_to(target) > 10:
		position += speed * direction * get_physics_process_delta_time()

func _on_vision_radius_area_entered(area):
	if area.name == "Bobber":
		print("Fish sees Bobber")
		target = area.global_position

func _on_move_timer_timeout():
	target += Vector2(randi_range(-move_radius, move_radius), randi_range(-move_radius, move_radius))
