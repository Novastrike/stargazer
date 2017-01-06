extends Node2D

export(String, FILE, '*.tscn') var star

var test_pos = Vector2(0,-150)
var test_add = true
var testing = true


func _ready():
	pass

func spawn_star(pos):
	var new_spawn = Position2D.new()
	new_spawn.set_pos(pos)
	var spawners = get_tree().get_nodes_in_group('spawner-area')
	if spawners.size() > 0:
		spawners[0].add_child(new_spawn)
		new_spawn.add_child(load(star).instance())

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

func _on_BalloonBody_explode():
	# FIXME: Spawner being freed
	var camera2 = get_tree().get_nodes_in_group('camera2')[0]
	camera2.set_global_pos(get_tree().get_nodes_in_group('camera1')[0].get_global_pos())
	camera2.make_current()
	print('Change Camera')
