class_name Spawner
extends Node2D

enum ItemType {
	COPPER_PLATE,
	COPPER_WIRE,
	IRON_PLATE,
	NAIL,
}

const sprites = {
	ItemType.COPPER_PLATE: preload("res://Assets/Items/copper_plate.png"),
	ItemType.COPPER_WIRE: preload("res://Assets/Items/copper_wire.png"),
	ItemType.IRON_PLATE: preload("res://Assets/Items/iron_plate.png"),
	ItemType.NAIL: preload("res://Assets/Items/nails.png")
}

var item: PackedScene = preload("res://src/Items/DraggableItem.tscn")



func _on_RecipeBuilder_spawn_item(kind, pos) -> void:
	var new_item: DraggableItem = item.instance()
	add_child(new_item)
	
	new_item.position = pos
	new_item.original_pos = pos
	new_item.scale = Vector2(2, 2)
	new_item.set_item(kind, sprites[kind])
