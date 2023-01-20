extends Control

const MAX_VALUE = 84
const WIDTH = 100
const HEIGHT = 18

export var current_value = 0

var counter = 0
var died = false

func _process(delta: float) -> void:
	counter += 1
	
	if counter == 10:
		increment()
		counter = 0


func increment():
	current_value += 1
	if current_value == MAX_VALUE +1:
		current_value = MAX_VALUE
		if !died:
			print("You died")
			died = true
		return
	
	$Heated.visible = true
	set_sprite()


func decrement():
	current_value -= 0
	if current_value < 0:
		current_value = 0
	
	$Heated.visible = false
	set_sprite()


func set_sprite():
	var region = Rect2(WIDTH * current_value, 0, WIDTH, HEIGHT)
	$Texture.texture.region = region
