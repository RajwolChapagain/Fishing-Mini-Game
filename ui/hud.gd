extends Control

@export var small_fish_sprite : Texture2D
@export var medium_fish_sprite : Texture2D
	
func set_num_small_fish_caught(value):
	$SmallFishContainer/SmallCaught.text = str(value)

func set_num_small_fish_to_catch(value):
	$SmallFishContainer/SmallToCatch.text = "/ " + str(value)
	
func set_num_medium_fish_caught(value):
	$MediumFishContainer/MediumCaught.text = str(value)

func set_num_medium_fish_to_catch(value):
	$MediumFishContainer/MediumToCatch.text = "/ " + str(value)

func set_clicks_to_catch(value):
	$NumClicks.text = str(value)
	
	if value == 0:
		$NumClicks.visible = false
	else:
		$NumClicks.visible = true
