extends Node2D

signal crack_number_changed(number)
signal increment()


const LOSE_RATE = 0.02 # 1 every 10 secs

export(Rect2) var spawn_zone
export(float) var total_score = 0.0

# unit : 100 ms (10Hz)
var internal_counter: int = 0
var crack = preload("res://src/WallCracks/WallCrack.tscn")

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	generate_crack(rng, true)
	spawn_cracks(rng)
	
	# restart global timer
	GlobalTimer.time_elapsed = 0
	GlobalTimer.paused = false
	GlobalTimer.start()


func _process(delta):
	var current_score = 0.0
	for c in $Cracks.get_children():
		current_score += float(c.status)
	
	# a score of 5 means 0.1 bar/sec
	current_score *= LOSE_RATE
	current_score *= delta
	
	var new_score = total_score + current_score
	if floor(new_score) != floor(total_score):
		emit_signal("increment")
	
	total_score = new_score

func spawn_cracks(rng: RandomNumberGenerator):
	while true:
		#pass
		var time_to_wait = 1.0 / current_spawn_rate(internal_counter)
		print("starting a timer for ", time_to_wait, " seconds, counter is ", internal_counter)
		yield(get_tree().create_timer(time_to_wait, false), "timeout")
		#print("generating an object")
		
		generate_crack(rng)

func generate_crack(rng: RandomNumberGenerator, force_zone = false):
	var x = rng.randi_range(spawn_zone.position.x, spawn_zone.position.x + spawn_zone.size.x)
	var y = rng.randi_range(spawn_zone.position.y, spawn_zone.position.y + spawn_zone.size.y)
	
	if force_zone:
		x = 220
		y = 45
	
	var new_crack = crack.instance()
	new_crack.position.x = x
	new_crack.position.y = y
	$Cracks.add_child(new_crack)
	ack_cracknb_changed()

func ack_cracknb_changed():
	emit_signal("crack_number_changed", $Cracks.get_child_count())

func current_spawn_rate(x) -> float:
	# since our counter is 10 Hz, we divide x by 10
	x = float(x)/10.0
	x = x * x
	x = x * 1.0/360_000.0
	x = x + 1.0/30.0
	return x


func _on_Timer_timeout() -> void:
	internal_counter += 1

