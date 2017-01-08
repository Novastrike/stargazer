extends Area2D

export(PackedScene) var test_scene
export(bool) var debug = false


func _ready():
	if debug:
		get_node("Spawn").add_to_group('spawner-box')
		get_node("TimerTest").start()
		spawn_at(test_scene.instance(), Vector2(0, 0))
		spawn_random(test_scene.instance())

func spawn_at(node, pos):
	var spawn_box = get_tree().get_nodes_in_group('spawner-box')
	if spawn_box.size() > 0:
		var new_spawn = Position2D.new()
		new_spawn.add_child(node)
		spawn_box[0].add_child(new_spawn)
		new_spawn.set_global_pos(pos)

func spawn_random(node):
	randomize()
	spawn_at(node, Vector2(x_random(), y_random()))

func x_random():
	return int(rand_range(get_global_pos().x, get_global_pos().x+OS.get_window_size().width+1))

func y_random():
	return int(rand_range(get_global_pos().y, get_global_pos().y+1))

func _on_TimerTest_timeout():
	spawn_random(test_scene.instance())
