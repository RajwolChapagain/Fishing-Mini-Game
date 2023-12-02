extends Control

func set_num_small_fish_caught(value):
	$HBoxContainer/SmallCaught.text = value

func set_num_small_fish_to_catch(value):
	$HBoxContainer/SmallToCatch.text = value
	
func set_num_medium_fish_caught(value):
	$HBoxContainer/MediumCaught.text = value

func set_num_medium_fish_to_catch(value):
	$HBoxContainer/MediumToCatch.text = value

func set_clicks_to_catch(value):
	$NumClicks.text = value
