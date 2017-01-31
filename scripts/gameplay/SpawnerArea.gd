# MIT License
#
# Copyright (c) 2017 NovastrikeMEDIA
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends Area2D

export(PackedScene) var test_scene
export var y_offset = 500
export(bool) var debug = false


func _ready():
	pass

func spawn_at(node, pos):
	if debug:
		print('SPAWN AT: ', pos)
		get_node("ColorFrame").set_global_pos(get_player_pos() - get_viewport().get_rect().size/2)
	var spawn_box = get_tree().get_nodes_in_group('spawner-box')
	if spawn_box.size() > 0:
		spawn_box[0].add_child(node)
		#node.reset()
		node.set_global_pos(pos)
		# diagonal impulse don't works
		#var impulse = Vector2(50, 0)
		#if pos.x >= get_viewport().get_rect().size.x*get_camera_zoom().x/2:
		#	impulse.x *= -1
		#node.apply_impulse(Vector2(1, 0), impulse)


func spawn_random(node):
	randomize()
	spawn_at(node, Vector2(x_random(), y_random()))

func get_player_pos():
	var player = get_tree().get_nodes_in_group('balloon-player')
	if player.size() > 0:
		return player[0].get_global_pos()
	return null

func get_camera_zoom():
	var camera = get_tree().get_nodes_in_group('camera')
	if camera.size() > 0:
		return camera[0].get_zoom()
	return Vector2(1, 1)

func x_random():
	var player = get_player_pos()
	if player != null:
		var viewport_size = get_viewport().get_rect().size
		var global_x = (player.x - (viewport_size.width * get_camera_zoom().x /2))
		return int(rand_range(global_x, global_x + viewport_size.width + 1))
	return 0

func y_random():
	var player = get_player_pos()
	if player != null:
		return (player.y - (y_offset*2)) - get_viewport().get_rect().size.y * get_camera_zoom().y
	return 0

func _on_TimerTest_timeout():
	spawn_random(test_scene.instance())
