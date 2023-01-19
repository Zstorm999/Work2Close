class_name Recipe
extends Resource

enum ItemType {
	COPPER_PLATE,
	COPPER_WIRE,
	IRON_PLATE,
	NAIL,
}

export(ItemType) var item1
export(ItemType) var item2
export(ItemType) var item3
export(ItemType) var result

func matches(items) -> bool:
	return item1 == items[0] and item2 == items[1] and item3 == items[2]
