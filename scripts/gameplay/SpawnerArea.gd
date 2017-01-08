extends Area2D

export(PackedScene) var test_scene
export(bool) var debug = false

onready var spawn_area = get_node("Area")
onready var spawn_box = get_node("Spawn")

func _ready():
	if debug:
		get_node("TimerTest").start()
		spawn_at(test_scene.instance(), Vector2(0, 0))
		spawn_random(test_scene.instance())

func _draw():
	if debug:
		draw_rect(spawn_area.get_rect(), Color(0, 0, 0))

func spawn_at(node, pos):
	# FIXME: Change spawn method
	var new_spawn = Position2D.new()
	new_spawn.set_pos(pos)
	spawn_box.add_child(new_spawn)
	new_spawn.add_child(node)

func spawn_random(node):
	randomize()
	spawn_at(node, Vector2(x_random(), y_random()))

func x_random():
	return int(rand_range(spawn_area.get_pos().x, spawn_area.get_size().width+1))

func y_random():
	return int(rand_range(spawn_area.get_pos().y, spawn_area.get_size().height+1))

func _on_TimerTest_timeout():
	spawn_random(test_scene.instance())
