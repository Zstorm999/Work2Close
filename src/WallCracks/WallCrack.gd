extends DropZone

signal destroyed()

var status = 1
var is_not_taken = true

func fill_slot(item: DraggableItem):
	if not is_not_taken:
		print("refused")
		return false
	
	if item.item_kind != Spawner.ItemType.WALLFIXER:
		return false
	
	is_not_taken = false
	
	# fixing a crack makes it less dangerous
	status = 1
	
	# shut down old animation
	$Crack.visible = false
	
	$Fixer.visible = true
	$Fixer.play("default")
	
	return true


func _on_Fixer_animation_finished():
	var destroyer = get_parent().get_parent()
	get_parent().remove_child(self)
	destroyer.ack_cracknb_changed()
	
	queue_free()


func _on_Crack_frame_changed():
	status += 1
