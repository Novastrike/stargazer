extends Node2D


func _ready():
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_left"):
		print('START GAEM')
		start_game()
		set_process(false)

func start_game():
	get_node("MainLayer/BalloonPlayer").unlock()
	get_node("AnimationPlayer").play("start_game")
