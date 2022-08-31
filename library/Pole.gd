tool
extends Spatial


onready var spawn_positions = $Spawn_positions
var platforms = ["res://library/assest_1.tscn","res://library/assest_2.tscn"]

var rng = RandomNumberGenerator.new()

func _ready():
	for i in range(0,spawn_positions.get_child_count()):
		rng.randomize()
		var rand = rng.randi_range(0,1)
		var obstacle = load(platforms[rand])
		var Obstacle = obstacle.instance()
		spawn_positions.get_child(i).add_child(Obstacle)
		Obstacle.rotation_degrees.y = rng.randi_range(0,360)
