extends DropZone

signal spawn_item(kind, pos)

export var item_kind = -1
export var quantity = 0

func _ready():
	if item_kind != -1 and quantity != 0:
		emit_signal("spawn_item", item_kind, position)
	
	$Label.text = String(quantity)

func fill_slot(item: DraggableItem):
	if item_kind == -1:
		item_kind = item.item_kind
		quantity = 1
		update_quantity()
		emit_signal("spawn_item", item_kind, position)
		return true
	
	if item_kind == item.item_kind:
		quantity += 1
		update_quantity()
		return true
	
	return false

func update_quantity():
	$Label.text = String(quantity)

