extends KinematicBody

var is_dead = false

var velocity = Vector3()
var colliding = false

onready var collider = $RayCast
onready var anim_player = $AnimationPlayer
onready var tween = $Tween

var speed = 15
var point = Vector3(0,0,0)

var falling :bool = false
var can_fall : bool = false

func _ready():
	is_dead = false
	pass

func _physics_process(_delta):
	if is_dead:
		get_tree().reload_current_scene()
		Instance._ready()
	
	if Instance.is_falling:
		falling = true
	else:
		falling = false
	
	
	if not collider.is_colliding():
		if can_fall:
			Instance.is_falling = true
			var direction
			if point.distance_to(transform.origin) > 1:
				direction = point - transform.origin
				direction = direction.normalized() * speed
			else:
				direction = point - transform.origin
	
	if Instance.is_falling == false:
		anim_player.play("Bounce")


func _on_Area_body_entered(body):
	if !body.is_in_group("player"):
		Instance.is_falling = false
		colliding = true
	if body.is_in_group("Black"):
		is_dead = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Bounce" && falling:
		anim_player.play("Fall")
	if anim_name == "Bounce":
		can_fall = true


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Bounce":
		can_fall = false
