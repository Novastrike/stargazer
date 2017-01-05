extends Node2D

export(PackedScene) var star

var test_pos = Vector2(0,-150)
var test_add = true
var testing = true


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func spawn_star(pos):
	var new_spawn = Position2D.new()
	new_spawn.set_pos(pos)
	get_node("Node2D/BalloonBody/Camera2D/SpawnerArea").add_child(new_spawn)
	new_spawn.add_child(star.instance())

func _on_Timer_timeout():
	if testing:
		spawn_star(test_pos)
		if test_add:
			test_pos.x += 50
		else:
			test_pos.x -= 50
		
		if test_pos.x < 0:
			test_add = true
		elif test_pos.x > 600:
			test_add = false