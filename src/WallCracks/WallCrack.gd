extends DropZone

var is_not_taken = true

func fill_slot(item: DraggableItem):
	if !is_not_taken:
		return false
	
	#if item.item_kind != Spawner.ItemType.WALLFIXER:
	#	return false
	
	# shut down old animation
	$Crack.visible = false
	
	$Fixer.visible = true
	$Fixer.play("default")
	
	return true
