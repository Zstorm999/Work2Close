class_name DropZone
extends Area2D

func _on_body_entered(body: Node) -> void:
	var item = body as DraggableItem
	if not item: 
		return
	
	item.set_target(self)


func _on_body_exited(body: Node) -> void:
	var item = body as DraggableItem
	if not item: 
		return
	
	item.clear_target(self)
