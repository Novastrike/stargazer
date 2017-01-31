extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	start_game()
	pass


func start_game():
	get_node("MainLayer/BalloonPlayer").unlock()
	get_node("AnimationPlayer").play("start_game")