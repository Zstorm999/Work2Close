extends VBoxContainer


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/TestLevel.tscn")


func _on_HtpButton_pressed():
	$ViewSelect.visible = false
	$HowToPlay.visible = true


func _on_CreditsButton_pressed():
	$ViewSelect.visible = false
	$Credits.visible = true


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	$Credits.visible = false
	$ViewSelect.visible = true
	$HowToPlay.visible = false
