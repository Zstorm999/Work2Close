extends Node2D

signal spawn_item(kind, pos)


enum AnimState {NOT_READY, BUILDING, DONE}
const animations = {
	AnimState.NOT_READY: "Empty",
	AnimState.BUILDING: "Loading",
	AnimState.DONE: "Done"
}

# RecipeList
export(Resource) var recipe_list

var is_full = [false, false, false]
var old_state = AnimState.NOT_READY
var current_state = AnimState.NOT_READY

onready var builder_sprite: AnimatedSprite = $BuilderSprite
onready var slot1 = $ItemSlot1
onready var slot2 = $ItemSlot2
onready var slot3 = $ItemSlot3


func _process(delta: float) -> void:
	if current_state == AnimState.NOT_READY and is_full[0] and is_full[1] and is_full[2]:
		current_state = AnimState.BUILDING
		slot1.build()
		slot2.build()
		slot3.build()
	
	if current_state != old_state:
		builder_sprite.play(animations[current_state])
		old_state = current_state


func _on_ItemSlot1_is_full(kind) -> void:
	is_full[0] = true


func _on_ItemSlot2_is_full(kind) -> void:
	is_full[1] = true


func _on_ItemSlot3_is_full(kind) -> void:
	is_full[2] = true


func _on_BuilderSprite_animation_finished() -> void:
	if current_state == AnimState.BUILDING:
		var recipe = recipe_list.search_recipe(slot1.item_kind, slot2.item_kind, slot3.item_kind)
		if recipe == null:
			print("No recipe found")
			is_full = [false, false, false]
			slot1.clear()
			slot2.clear()
			slot3.clear()
			
			current_state = AnimState.NOT_READY
			return
		
		# we found a recipe !
		print("recipe found :", recipe)
		
		var spawn_point = $Output.global_position
		emit_signal("spawn_item", recipe.result, spawn_point)
