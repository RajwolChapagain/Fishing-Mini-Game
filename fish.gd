extends Area2D

@export var speed = 400
@export var move_radius = 400
@export var clicks_to_catch = 1
@export var escape_time = 3
@onready var target = global_position

var water_level = 0
var shore_line = 1000
var hooked = false

signal fish_hooked(clicks_to_catch)
signal fish_escaped(clicks_to_catch)
signal big_fish_despawned

func _ready():
	$EscapeTimer.wait_time = escape_time
	
func _physics_process(_delta):
	if not hooked:
		move_to_target()
	clamp_position() #Below water level and to the left of the shoreline
	
func move_to_target():
	var direction = global_position.direction_to(target)
	
	if global_position.distance_to(target) > 2:
		global_position += speed * direction * get_physics_process_delta_time()

func _on_vision_radius_area_entered(area):
	if area.name == "Bobber":
		if area.get_parent().can_catch_fish:
			set_target(area.global_position)

func _on_move_timer_timeout():
	var new_pos
	
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		new_pos = global_position + Vector2(move_radius, -move_radius)
	else:
		new_pos = global_position + Vector2(randi_range(-move_radius, move_radius), randi_range(-move_radius, move_radius))
		
	set_target(new_pos)
	$MoveTimer.wait_time = randi_range(2, 5)

func clamp_position():
	var horizontal_leeway = $Sprite2D.texture.get_width()
	var vertical_leeway = $Sprite2D.texture.get_height()
	global_position.x = clamp(global_position.x, -horizontal_leeway, get_viewport_rect().size.x + horizontal_leeway)
	global_position.y = clamp(global_position.y, water_level, get_viewport_rect().size.y + vertical_leeway)

func set_water_level(level):
	water_level = level
	
func set_shore_line(line):
	shore_line = line

func _on_area_entered(area):
	if area.name == "Bobber":
		if area.get_parent().can_catch_fish:
			hooked = true
			$MoveTimer.stop()
			$EscapeTimer.start()
			fish_hooked.emit(clicks_to_catch)
		
func _on_escape_timer_timeout():
	hooked = false
	target += Vector2(-400, 400)
	$MoveTimer.start()
	fish_escaped.emit(clicks_to_catch)

func _on_visible_on_screen_notifier_2d_screen_exited():
	if is_in_group("big_fish"):
		big_fish_despawned.emit()
	queue_free()

func set_target(pos):
	$Sprite2D.flip_h = pos.x > global_position.x
	target = pos

func get_spooked(source_pos, spook_radius):
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		return
		
	var additional_distance = 10
	var distance_to_hook = global_position.distance_to(source_pos)
	var distance_to_move = spook_radius - distance_to_hook + additional_distance
	set_target(global_position + source_pos.direction_to(global_position) * distance_to_move)
