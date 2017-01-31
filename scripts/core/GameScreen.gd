extends Node2D

signal game_over

func _ready():
	print(OS.get_cmdline_args())
	get_node("MainLayer/BalloonPlayer").connect("no_player", self, '_on_BalloonPlayer_no_player')
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_left"):
		print('START GAEM')
		start_game()
		set_process(false)

func start_game():
	get_node("MainLayer/BalloonPlayer").unlock()
	get_node("AnimationPlayer").play("start_game")

func _on_AnimationPlayer_finished():
	if get_node("HUD/GameHUD/AnimationPlayer").get_current_animation() == 'start':
		get_node("MainLayer/SpawnerTimer").start()

func _on_BalloonPlayer_no_player():
	emit_signal('game_over')

