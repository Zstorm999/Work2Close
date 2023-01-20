extends Node2D

export var min_disp: int
export var max_disp: int

var drag_enabled = false
var click_position: float
var reference_position: float

onready var content = $Content


func _process(_delta: float) -> void:
	
	if drag_enabled:
		var displacement = get_global_mouse_position().x - click_position
		content.position.x = clamp(reference_position + displacement, min_disp, max_disp)
		
		if content.position.x == min_disp:
			$RightArrow.visible = false
		else:
			$RightArrow.visible = true
		
		if content.position.x == max_disp:
			$LeftArrow.visible = false
		else:
			$LeftArrow.visible = true


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if drag_enabled and !event.pressed:
				# releasing
				drag_enabled = false
				reference_position = content.position.y
			elif !drag_enabled and event.pressed:
				click_position = get_global_mouse_position().x
				reference_position = content.position.x
				drag_enabled = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if drag_enabled and !event.pressed:
				# releasing
				drag_enabled = false
				reference_position = content.position.y
