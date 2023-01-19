class_name Recipe
extends Resource

export(Spawner.ItemType) var item1
export(Spawner.ItemType) var item2
export(Spawner.ItemType) var item3
export(Spawner.ItemType) var result

func matches(items) -> bool:
	return item1 == items[0] and item2 == items[1] and item3 == items[2]
