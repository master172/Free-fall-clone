extends Spatial

var Legnth = 0
onready var timer = $Timer

export(float,1.0,1.5) var MAX_DIAGONAL_SLOPE = 1.3

const move_speed = -0.1

var swipe_start_position = Vector2()

var prev_spawn_location = -20

var first_pole_deleted = false

onready var pole = preload("res://library/Pole.tscn")

var num_pole_loaded = 2
var score :int = 0

var prev_lowest = 0

onready var Top_pole = $MeshInstance
onready var players_follower = $Follower
onready var Player = $Player
onready var score_label = get_node("%Score_Label")

signal swiped(direction)
signal swipe_cancelled(start_position)



func _ready():
	Legnth = 21


func _input(event):
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		_start_detection(event.position)
	elif not timer.is_stopped():
		_end_detection(event.position)


func _start_detection(position):
	swipe_start_position = position
	timer.start()

func _end_detection(position):
	timer.stop()
	var direction = (position - swipe_start_position).normalized()
	if abs(direction.x) + abs(direction.y) >= MAX_DIAGONAL_SLOPE:
		return
	
	if abs(direction.x) > abs(direction.y):
		emit_signal("swiped" ,Vector2(-sign(direction.x), 0.0))
	else:
		emit_signal("swiped",Vector2(0.0,-sign(direction.y)))

func _on_Timer_timeout():
	emit_signal("swipe_cancelled",swipe_start_position)


func _on_Player_spawn():
	num_pole_loaded += 1
	prev_spawn_location -= 20
	var Pole = pole.instance()
	Pole.translation.y = prev_spawn_location
	Pole.name = "Pole" + String(num_pole_loaded)
	$Pole.add_child(Pole)
	if first_pole_deleted == true:
		$Pole.get_child(0).queue_free()
		if is_instance_valid(Top_pole):
			Top_pole.queue_free()
	elif first_pole_deleted == false:
		first_pole_deleted = true

func _physics_process(delta):
	score_label.text = String(score)
	if prev_lowest > Player.lowest:
		prev_lowest = Player.lowest
		players_follower.translation.y = Player.lowest + 5

	if is_instance_valid(Top_pole):
		Top_pole.rotation_degrees.y = $Pole.rotation_degrees.y


func _on_Area_body_entered(body:Node):
	if body.is_in_group("Obstacle"):
		body.queue_free()
		score += 1
