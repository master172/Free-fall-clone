extends KinematicBody

var reflect = Vector3.ZERO
var velocity = Vector3.ZERO

var lowest :float
var highest : float

var first_collision = false

var prev_lowest = 0

signal spawn
signal delete

func _physics_process(delta):
	if translation.y <= lowest:
		lowest = translation.y
		
		
		if prev_lowest -20 > lowest:
			prev_lowest = lowest
			emit_signal("spawn")
			print("spawn")

	var collision = move_and_collide(velocity * delta)
	if collision:
		first_collision = true
		reflect = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		reflect.y = clamp(reflect.y,-50,5)
		move_and_collide(reflect)
	
	if not is_on_floor():
		if first_collision != false:
			if translation.y >= highest:
				highest = translation.y
		velocity.y -= 9.8 * delta
		velocity.y = clamp(velocity.y,-50,5)
		move_and_slide(velocity)


func _on_Area_body_entered(body:Node):
	if body.is_in_group("Black"):
		get_tree().reload_current_scene()
