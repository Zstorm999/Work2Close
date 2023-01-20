extends Node2D

export(Rect2) var spawn_zone

# unit : 100 ms (10Hz)
var internal_counter: int = 0
var crack = preload("res://src/WallCracks/WallCrack.tscn")


func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	generate_crack(rng)
	spawn_cracks(rng)


func spawn_cracks(rng: RandomNumberGenerator):
	while true:
		#pass
		var time_to_wait = 1.0 / current_rate(internal_counter)
		print("starting a timer for ", time_to_wait, " seconds, counter is ", internal_counter)
		yield(get_tree().create_timer(10, false), "timeout")
		#print("generating an object")
		
		generate_crack(rng)

func generate_crack(rng: RandomNumberGenerator, force_zone = null):
	var x = rng.randi_range(spawn_zone.position.x, spawn_zone.position.x + spawn_zone.size.x)
	var y = rng.randi_range(spawn_zone.position.y, spawn_zone.position.y + spawn_zone.size.y)
	
	var new_crack = crack.instance()
	new_crack.position.x = x
	new_crack.position.y = y
	$Cracks.add_child(new_crack)

func current_rate(x) -> float:
	# since our counter is 10 Hz, we divide x by 10
	
	
	x = float(x)/10.0
	x = x * x
	x = x * 1.0/360_000.0
	x = x + 1.0/30.0
	return x


func _on_Timer_timeout() -> void:
	internal_counter += 1

