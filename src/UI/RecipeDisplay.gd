extends Control

onready var item1 = $HBoxContainer/Item1
onready var item2 = $HBoxContainer/Item2
onready var item3 = $HBoxContainer/Item3
onready var result = $HBoxContainer/Result



func set_recipe(recipe: Recipe):
	item1.texture = Spawner.sprites[recipe.item1]
	item2.texture = Spawner.sprites[recipe.item2]
	item3.texture = Spawner.sprites[recipe.item3]
	
	result.texture = Spawner.sprites[recipe.result]
