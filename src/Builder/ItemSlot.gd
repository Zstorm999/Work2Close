extends Area2D

signal is_full(kind)

enum AnimState {EMPTY, FILLING, FULL, BUILDING, DONE, EMPTYING}

const animations = {
	AnimState.EMPTY: "IdleEmpty",
	AnimState.FILLING: "Filling",
	AnimState.FULL: "IdleFull",
	AnimState.BUILDING: "Building",
	AnimState.DONE: "DoneBuilding",
	AnimState.EMPTYING: "Emptying",
}


var item = -1 # 1 is undefined
var is_available = true
var old_state = AnimState.EMPTY
var current_state = AnimState.EMPTY

onready var item_sprite = $CopperPlate
onready var slot_sprite = $SlotSprite

func _process(delta: float) -> void:
	if old_state != current_state:
		slot_sprite.play(animations[current_state])
	
	old_state = current_state


func fill_slot(item: DraggableItem):
	if not is_available:
		return false
	
	item_sprite.visible = true
	is_available = false
	current_state = AnimState.FILLING
	
	return true


func build():
	current_state = AnimState.BUILDING

func clear():
	current_state = AnimState.EMPTYING


func _on_body_entered(body: Node) -> void:
	var item = body as DraggableItem
	if not item: 
		return
	
	item.set_target(self)


func _on_ItemSlot_body_exited(body: Node) -> void:
	var item = body as DraggableItem
	if not item: 
		return
	
	item.clear_target(self)



func _on_animation_finished() -> void:
	match current_state:
		AnimState.EMPTY, AnimState.FULL, AnimState.DONE:
			pass # self contained animations
		AnimState.BUILDING:
			current_state = AnimState.DONE
		AnimState.FILLING:
			current_state = AnimState.FULL
			emit_signal("is_full", 0)
		AnimState.EMPTYING:
			current_state = AnimState.EMPTY
			item = -1
			is_available = true
			item_sprite.visible = false
