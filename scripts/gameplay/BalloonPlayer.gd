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

extends Node2D

var random_balloon

func _ready():
	get_node("BasketBody").set_mode(RigidBody2D.MODE_STATIC)
	var balloons = get_tree().get_nodes_in_group('balloon-body')
	randomize()
	random_balloon = balloons[int(rand_range(0, balloons.size()))]
	random_balloon.add_to_group('front-balloon')
	random_balloon.set_collision_mask(2)
	random_balloon.set_layer_mask(2)
	random_balloon.set_z(random_balloon.get_z()+1)
	
	for balloon in balloons:
		if not 'front-balloon' in balloon.get_groups():
			balloon.connect('explode', self, '_on_balloon_explode')

func unlock():
	get_node("BasketBody").set_mode(RigidBody2D.MODE_RIGID)

func _on_balloon_explode():
	var front_balloon = get_tree().get_nodes_in_group('front-balloon')
	if front_balloon.size() > 0:
		front_balloon[0].set_collision_mask(1)
		front_balloon[0].set_layer_mask(1)
