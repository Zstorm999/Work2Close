class_name DraggableItem
extends KinematicBody2D

signal destroyed()

export var item_kind = -1

var drag_enabled = false
var target_item_slot : Node = null
var parent_changed = false

onready var original_pos : Vector2 = position
onready var original_parent: Node = get_parent()


func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if not event.pressed and drag_enabled:
				on_dropped()
			drag_enabled = event.pressed


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			if drag_enabled and position != original_pos:
				on_dropped()
			drag_enabled = false


func _physics_process(_delta: float) -> void:
	var movement : Vector2
	
	if drag_enabled:
		if !parent_changed:
			var new_parent = get_node("/root/Level/Dragging")
			original_parent.remove_child(self)
			new_parent.add_child(self)
			parent_changed = true
			
		var new_position = get_global_mouse_position()
		movement = new_position - global_position
	elif target_item_slot == null:
		# not on target, return to your original position !
		movement = original_pos - position
	
# warning-ignore:return_value_discarded
	move_and_collide(movement)


func connect_caller(caller: Node):
	connect("destroyed", caller, "on_item_destroyed")


func set_target(sender: Node):
	target_item_slot = sender


func clear_target(sender: Node):
	# ignore if the sender is not the current target
	# this can happen if moving too quickly and already entered a new target
	if target_item_slot == sender:
		target_item_slot = null


func set_item(kind, texture):
	item_kind = kind
	$Sprite.texture = texture


func get_texture() -> Texture:
	return $Sprite.texture


func on_dropped():
	if target_item_slot == null:
		# reset to original parent
		get_parent().remove_child(self)
		original_parent.add_child(self)
		parent_changed = false
		return
	
	var filled = target_item_slot.fill_slot(self)
	if filled:
		emit_signal("destroyed")
		queue_free()
	else:
		# if the target was not available, we simply invalidate it
		# this will reset the item position on the next frame
		get_parent().remove_child(self)
		original_parent.add_child(self)
		parent_changed = false
		target_item_slot = null
