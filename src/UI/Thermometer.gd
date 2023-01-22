extends Control

const MAX_VALUE = 84
const WIDTH = 100
const HEIGHT = 18

export var current_value = 0

var died = false


func increment():
	current_value += 1
	if current_value == MAX_VALUE +1:
		current_value = MAX_VALUE
		if !died:
			GlobalTimer.paused = true
			print("You died")
			print("You survived ", GlobalTimer.get_minutes(), ":", GlobalTimer.get_seconds())
			get_tree().change_scene("res://Scenes/DiedScene.tscn")
			died = true
		return
	
	$HBoxContainer/Texture/Heated.visible = true
	set_sprite()


func decrement():
	current_value -= 0
	if current_value < 0:
		current_value = 0
	
	$HBoxContainer/Texture/Heated.visible = false
	set_sprite()


func set_cracks_number(number):
	if number == 0:
		$HBoxContainer/Texture/Heated.visible = false
	
	$HBoxContainer/Label.text = String(number)


func set_sprite():
	var region = Rect2(WIDTH * current_value, 0, WIDTH, HEIGHT)
	$HBoxContainer/Texture.texture.region = region


