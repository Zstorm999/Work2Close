extends ScrollContainer

export(Resource) var recipe_list

var recipe_display = preload("res://src/UI/RecipeDisplay.tscn")

func _ready() -> void:
	
	for r in recipe_list.recipes:
		var new_recipe = recipe_display.instance()
		$VBoxContainer.add_child(new_recipe)
		new_recipe.set_recipe(r)
		
