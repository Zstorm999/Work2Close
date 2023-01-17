class_name DraggableItem
extends KinematicBody2D


var drag_enabled = false
var target_item_slot : Node = null

onready var original_pos : Vector2 = position


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drag_enabled = event.pressed
			if !event.pressed:
				on_dropped()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			drag_enabled = false
			on_dropped()


func _physics_process(delta: float) -> void:
	var movement : Vector2
	
	if drag_enabled:
		var new_position = get_global_mouse_position()
		movement = new_position - position
	elif target_item_slot == null:
		# not on target, return to your original position !
		movement = original_pos - position
	
	move_and_collide(movement)


func _process(delta: float) -> void:
	print(target_item_slot)


func set_target(sender: Node):
	target_item_slot = sender


func clear_target(sender: Node):
	# ignore if the sender is not the current target
	# this can happen if moving too quickly and already entered a new target
	if target_item_slot == sender:
		target_item_slot = null


func on_dropped():
	if target_item_slot == null:
		return
	
	var filled = target_item_slot.fill_slot(self)
	if filled:
		queue_free()
	else:
		# if the target was not available, we simply invalidate it
		# this will reset the item position on the next frame
		target_item_slot = null
