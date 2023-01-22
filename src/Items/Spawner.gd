class_name Spawner
extends Node2D

enum ItemType {
	COPPER_PLATE,
	COPPER_WIRE,
	IRON_PLATE,
	NAIL,
	WOOD,
	HAMMER,
	GEAR,
	SHOVEL,
	WALLFIXER,
}

const sprites = {
	ItemType.COPPER_PLATE: preload("res://Assets/Items/copper_plate.png"),
	ItemType.COPPER_WIRE: preload("res://Assets/Items/copper_wire.png"),
	ItemType.IRON_PLATE: preload("res://Assets/Items/iron_plate.png"),
	ItemType.NAIL: preload("res://Assets/Items/nails.png"),
	ItemType.WOOD: preload("res://Assets/Items/wood.png"),
	ItemType.HAMMER: preload("res://Assets/Items/hammer.png"),
	ItemType.GEAR: preload("res://Assets/Items/gear.png"),
	ItemType.SHOVEL: preload("res://Assets/Items/shovel.png"),
	ItemType.WALLFIXER: preload("res://Assets/Items/wall_fixer.png"),
}

var item: PackedScene = preload("res://src/Items/DraggableItem.tscn")


func _on_spawn_item(kind, pos, caller) -> void:
	var new_item: DraggableItem = item.instance()
	add_child(new_item)
	
	new_item.connect_caller(caller)
	new_item.global_position =  pos
	new_item.original_pos = new_item.position
	new_item.scale = Vector2(2, 2)
	new_item.set_item(kind, sprites[kind])

