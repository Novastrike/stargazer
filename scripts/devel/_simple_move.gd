extends KinematicBody2D


var speed = 300

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	
	var movement = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		movement.x = 1
		set_rot(get_rot()-delta)
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1
		set_rot(get_rot()+delta)
	
	move(movement * speed * delta)
