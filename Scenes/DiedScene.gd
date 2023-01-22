extends ColorRect

func _ready():
	var minutes = GlobalTimer.get_minutes()
	var seconds = GlobalTimer.get_seconds()
	$VBoxContainer/Survived.text = "You survived " + String(minutes) + ":" + String(seconds)


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/TestLevel.tscn")


func _on_MenuButton_pressed():
	pass # Replace with function body.
