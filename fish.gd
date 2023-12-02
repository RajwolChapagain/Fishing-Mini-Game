extends Area2D

@export var speed = 400
@export var move_radius = 400

@onready var target = global_position

var water_level = 0
var shore_line = 1000

func _physics_process(_delta):
	move_to_target()
	clamp_position() #Below water level and to the left of the shoreline
	
func move_to_target():
	var direction = global_position.direction_to(target)
	
	if global_position.distance_to(target) > 10:
		global_position += speed * direction * get_physics_process_delta_time()

func _on_vision_radius_area_entered(area):
	if area.name == "Bobber":
		target = area.global_position

func _on_move_timer_timeout():
	target += Vector2(randi_range(-move_radius, move_radius), randi_range(-move_radius, move_radius))

func clamp_position():
	global_position.x = clamp(global_position.x, 0, shore_line)
	global_position.y = clamp(global_position.y, water_level, get_viewport_rect().size.y)
