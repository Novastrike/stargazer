"""
MIT License

Copyright (c) 2017 NovastrikeMEDIA

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

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
		spawn_box[0].add_child(node)
		node.reset()
		node.set_global_pos(pos)

func spawn_random(node):
	randomize()
	spawn_at(node, Vector2(x_random(), y_random()))

func x_random():
	var cameras = get_tree().get_nodes_in_group('camera')
	if cameras.size() > 0:
		var global_x = get_global_pos().x
		var viewport_size = get_viewport().get_rect().size
		return int(rand_range(global_x, global_x + viewport_size.width * cameras[0].get_zoom().x + 1))

func y_random():
	return int(rand_range(get_global_pos().y, get_global_pos().y+1))

func _on_TimerTest_timeout():
	spawn_random(test_scene.instance())
