extends DropZone

signal spawn_item(kind, pos, caller)

export var item_kind = -1
export var quantity = 0

var spot_available = true

func _ready():
	if item_kind != -1 and quantity != 0:
		spawn_item()
	
	$Label.text = String(quantity)


func _process(_delta):
	spot_available = true


func fill_slot(item: DraggableItem):
	if not spot_available: # hot fix for a strange bug
		return false
	
	if item_kind == -1:
		item_kind = item.item_kind
		quantity = 1
		update_quantity()
		spawn_item()
		return true
	
	if item_kind == item.item_kind:
		quantity += 1
		update_quantity()
		return true
	
	return false


func update_quantity():
	$Label.text = String(quantity)


func spawn_item():
	emit_signal("spawn_item", item_kind, position, self)


func on_item_destroyed():
	quantity -= 1
	if quantity != 0:
		spawn_item()
	else:
		item_kind = -1
	
	update_quantity()

