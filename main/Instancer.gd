extends Spatial

const Asset_1 = preload("res://library/assest_1.tscn")
const Asset_2 = preload("res://library/assest_2.tscn")

var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
func _ready():
	pass


func instance():
	rng.randomize()
	var rand_number = rng.randi_range(0,1)
	if rand_number == 1:
		var asset_1 = Asset_1.instance()
		asset_1.translation = self.translation
		rng2.randomize()
		var rotat = rng.randf_range(0.0,360.0)
		asset_1.rotation_degrees.y = rotat
		var enemy_pole = Utils._get_enemy_pole()
		enemy_pole.add_child(asset_1)
	elif rand_number == 0:
		var asset_2 = Asset_2.instance()
		asset_2.translation = self.translation
		rng2.randomize()
		var rotat = rng.randf_range(0.0,360.0)
		asset_2.rotation_degrees.y = rotat
		var enemy_pole = Utils._get_enemy_pole()
		enemy_pole.add_child(asset_2)
