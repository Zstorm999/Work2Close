extends DropZone

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


var item_kind = -1 # 1 is undefined
var is_available = true
var old_state = AnimState.EMPTY
var current_state = AnimState.EMPTY

onready var item_sprite = $ItemSprite
onready var slot_sprite = $SlotSprite


func _process(delta: float) -> void:
	if old_state != current_state:
		slot_sprite.play(animations[current_state])
	
	old_state = current_state


func fill_slot(item: DraggableItem):
	if not is_available:
		print("refused")
		return false
	
	item_kind = item.item_kind
	item_sprite.texture = item.get_texture()
	
	item_sprite.visible = true
	is_available = false
	current_state = AnimState.FILLING
	
	
	return true


func build():
	current_state = AnimState.BUILDING


func clear():
	current_state = AnimState.EMPTYING


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
			item_kind = -1
			is_available = true
			item_sprite.visible = false
