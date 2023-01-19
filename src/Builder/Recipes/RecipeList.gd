class_name RecipeList
extends Resource

export(Array, Resource) var recipes 

func search_recipe(item1, item2, item3):
	for r in recipes:
		var rec = r as Recipe
		var items = [item1, item2, item3]
		items.sort()
		
		if rec.matches(items):
			return rec
	
	# no recipe found
	return null
