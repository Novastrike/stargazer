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

extends Timer

export(PackedScene) var object_scene
export(String) var spawner_area = ''
export(String) var pool_name = ''
export(bool) var pool_enabled = false
export(bool) var spawn setget _toggle_spawn
export var debug = false

var node_name

func _ready():
	if pool_enabled:
		Pool.create_pool(pool_name)
	if debug:
		if object_scene == null:
			object_scene = PackedScene.new()

func _toggle_spawn(value):
	spawn = value
	if value:
		start()
	else:
		stop()

func spawn_node():
	var object_node
	var spawners = get_tree().get_nodes_in_group(spawner_area)
	if spawners.size() > 0:
		if pool_enabled and Pool.has_objects(pool_name):
			object_node = pool_instance()
		else:
			object_node = new_instance()
		spawners[0].spawn_random(object_node)
		object_node.connect('destruct', self, '_on_node_destruct')
		if debug:
			print(object_node.get_name())

func new_instance():
	var obj = object_scene.instance()
	node_name = obj.get_name()
	return obj

func pool_instance():
	var obj = Pool.get_object(pool_name)
	obj.set_name(node_name)
	return obj

func _on_node_destruct(node):
	if pool_enabled:
		Pool.push_object(node, 'stars')
		node.disconnect('destruct', self, '_on_node_destruct')
		node.get_parent().remove_child(node)
	else:
		node.queue_free()

func _on_SpawnerTimer_timeout():
	if debug:
		print('Spawn ON')
	spawn_node()
