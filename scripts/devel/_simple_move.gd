extends RigidBody2D


var speed = 600

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	
	var movement = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		movement.x = 1
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1
	var offset = Vector2(1,0)
	var impulse = movement * Vector2(speed * delta, 0)
	print('OFFSET:', offset)
	print('IMPULSE', impulse)
	apply_impulse(offset, impulse)
