extends Timer

var time_elapsed = 0


func _on_timeout():
	time_elapsed += 1


func get_minutes():
	return floor(time_elapsed / 60)

func get_seconds():
	return time_elapsed % 60
