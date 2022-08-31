extends Spatial

const rot_speed = 5
var NewDeltaX
var DeltaX
var TouchPos = Vector3()
var AreaEnt = false



func _ready():
	pass

func _physics_process(_delta):


	if Input.is_action_pressed("ui_left"):
		self.rotation_degrees.y += rot_speed
	elif Input.is_action_pressed("ui_right"):
		self.rotation_degrees.y -= rot_speed
	else:
		self.rotation_degrees.y = rotation_degrees.y

func _on_TouchScreenButton_pressed():
	AreaEnt = true


func _on_TouchScreenButton_released():
	AreaEnt = false


	
func _input(event):
	if AreaEnt == true:
		if event is InputEventScreenTouch and event.is_pressed():
			TouchPos = event.get_position()
			DeltaX = TouchPos.x - translation.x
		elif event is InputEventScreenDrag:
			TouchPos = event.get_position()
			NewDeltaX = TouchPos.x - DeltaX
			self.rotation_degrees.y = NewDeltaX
