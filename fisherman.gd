extends Sprite2D

var water_level = global_position.y
var is_thrown = false
var fish_hooked = false
var clicks_to_pull = 0:
	get:
		return clicks_to_pull
	set(value):
		clicks_to_pull = clamp(value, 0, 100)
		clicks_to_pull_changed.emit(clicks_to_pull)
var small_fish_caught = 0
var medium_fish_caught = 0

signal caught_small_fish(small_fish_count)
signal caught_medium_fish(medium_fish_count)
signal caught_large_fish
signal clicks_to_pull_changed(clicks_to_pull)

func _ready():
	$FishingLine.add_point($Marker2D.position)
	$FishingLine.add_point($Bobber.position)

func _physics_process(delta):
	$FishingLine.points[1] = $Bobber.position
	
func _input(event):
	if event.is_action_pressed("throw_line"):
		if is_thrown:
			clicks_to_pull -= 1
			if clicks_to_pull == 0:
				pull_fishing_line()
		else:
			throw_fishing_line(get_global_mouse_position())
	
func throw_fishing_line(pos):
	if pos.x < $Marker2D.global_position.x and pos.y > water_level:
		$Bobber.global_position = pos
		is_thrown = true
		$Bobber/SpookRadius/Sprite2D.visible = true
		var tween = get_tree().create_tween()
		tween.tween_property($Bobber/SpookRadius/Sprite2D, "scale", Vector2(1, 1), 0.3)
		await get_tree().create_timer(0.5).timeout
		$Bobber/SpookRadius.monitorable = false
		$Bobber/SpookRadius/Sprite2D.scale = Vector2.ZERO
		$Bobber/SpookRadius/Sprite2D.visible = false		
		
func pull_fishing_line():
	clicks_to_pull = 0
	catch_hooked_fish()
	$Bobber.position = $Marker2D.position
	$Bobber/SpookRadius.monitorable = true
	is_thrown = false

func _on_bobber_area_entered(area):
	if area.is_in_group("fish"):
		fish_hooked = true

func increment_clicks_to_pull(clicks):
	clicks_to_pull += clicks

func decrement_clicks_to_pull(clicks):
	clicks_to_pull -= clicks
	
func catch_hooked_fish():
	for area in $Bobber.get_overlapping_areas():
		if area.is_in_group("fish"):
			if area.hooked:
				if area.is_in_group("small_fish"):
					small_fish_caught += 1
					caught_small_fish.emit(small_fish_caught)
				elif area.is_in_group("medium_fish"):
					medium_fish_caught += 1
					caught_medium_fish.emit(medium_fish_caught)
				elif area.is_in_group("big_fish"):
					caught_large_fish.emit()
				area.queue_free()
