extends DropZone

signal spawn_item(kind, pos, caller)

export var item_kind = 2 # iron
export var drop_quantity = 5

var remaining = 0
var spawn_points = [
	Vector2(50, 17),
	Vector2(-51, 16),
	Vector2(17, 51),
	Vector2(-18, 51),
	Vector2(50, -18),
	Vector2(-51, -18),
]

func fill_slot(item: DraggableItem):
	if item.item_kind != Spawner.ItemType.SHOVEL:
		return false
	
	if remaining != 0:
		return false # cannot mine twice the same deposite without collecting
	
	for i in range(drop_quantity):
		var pos = position + spawn_points[i]
		emit_signal("spawn_item", item_kind, pos, self)
	
	print("item  dropped")
	
	remaining = drop_quantity
	return true


func on_item_destroyed():
	remaining -= 1
