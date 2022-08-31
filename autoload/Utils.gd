extends Node


func _ready():
	pass


func get_Instancer():
	return get_node("/root/Main/Pole/Spatial/Instancer")


func _get_enemy_pole():
	return get_node("/root/Main/Pole/Spatial")