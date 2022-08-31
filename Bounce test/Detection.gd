extends Area

var is_colliding = false

func _ready():
	pass


func _on_Detection_body_entered(body:Node):
	is_colliding = true


func _on_Detection_body_exited(body:Node):
	is_colliding = false
