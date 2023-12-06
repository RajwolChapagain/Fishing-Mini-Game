extends Sprite2D

@export var pull_sprite : Texture2D
@export var cast_sprite : Texture2D

var water_level = global_position.y
var is_thrown = false
var fish_hooked = false
var throwing = false
var can_catch_fish = false
var splash_sound_played = false
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

func _physics_process(_delta):
	$FishingLine.points[1] = $Bobber.position
	
	if $Bobber/SpookRadius.monitoring:
		for area in $Bobber/SpookRadius.get_overlapping_areas():
			if area.is_in_group("fish"):
				area.get_spooked($Bobber.global_position, $Bobber/SpookRadius/CollisionShape2D.shape.radius)
	
	if not splash_sound_played and $Bobber.global_position.y > water_level:
		$Bobber/SplashSound.play()
		splash_sound_played = true
	
func _input(event):
	if event.is_action_pressed("throw_line"):
		if is_thrown:
			clicks_to_pull -= 1
			if clicks_to_pull == 0 and not throwing:
				pull_fishing_line()
		else:
			throw_fishing_line(get_global_mouse_position())
	
func throw_fishing_line(pos):
		
	if pos.x < $CastMarker.global_position.x and pos.y > water_level:
		texture = cast_sprite
		$FishingLine.points[0] = $CastMarker.position
		
		var bobber_tween = get_tree().create_tween()
		throwing = true
		is_thrown = true
		await bobber_tween.tween_property($Bobber, "global_position", pos, 0.5).finished
		throwing = false
		$CatchTimer.start()
		$Bobber/SpookRadius.monitoring = true
		await get_tree().create_timer(0.5).timeout
		$Bobber/SpookRadius.monitoring = false	
		
		
func pull_fishing_line():
	splash_sound_played = false
	$CatchTimer.stop()
	can_catch_fish = false
	$FishingLine.points[0] = $Marker2D.position
	texture = pull_sprite
	clicks_to_pull = 0
	if catch_hooked_fish():
		$FishCaughtSound.play()		
	else:
		$Bobber/PullOutSound.play()
		
	$Bobber.position = $Marker2D.position
	is_thrown = false

func _on_bobber_area_entered(area):
	if area.is_in_group("fish"):
		fish_hooked = true

func increment_clicks_to_pull(clicks):
	if not $Bobber/FishHookedSound.playing:
		$Bobber/FishHookedSound.play()
	clicks_to_pull += clicks

func decrement_clicks_to_pull(clicks):
	clicks_to_pull -= clicks
	
func catch_hooked_fish():
	var caught = false
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
				caught = true
	
	return caught

func _on_catch_timer_timeout():
	can_catch_fish = true
