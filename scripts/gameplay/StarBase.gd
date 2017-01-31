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

extends RigidBody2D

signal explode
signal gotcha
signal out_of_screen
signal destruct(node)

export(int, 'Common', 'Special') var type = 0
export(int) var points = 1

var instance_count = 0
var anime

func _ready():
	anime = get_node('AnimationPlayer')
	set_fixed_process(true)

func _fixed_process(delta):
	var cameras = get_tree().get_nodes_in_group('camera')
	if cameras.size() > 0:
		if abs(cameras[0].get_global_pos().y - get_global_pos().y) >= cameras[0].get_zoom().y * get_viewport().get_rect().size.height+50:
			print('Out of screen')
			Score.combo_break()
			emit_signal('out_of_screen')
			destruct()

func reset():
	instance_count += 1
	#print(instance_count)
	get_node('AnimationPlayer').play("reset")

func destruct():
	emit_signal('destruct', self)

func explode():
	Score.combo_break()
	anime.play("explode")

func gotcha():
	Score.push_star(type, points)
	anime.play("gotcha")


func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		emit_signal('explode')
		destruct()
	elif anime.get_current_animation() == 'gotcha':
		emit_signal('gotcha')
		destruct()


func _on_VisibilityNotifier2D_enter_screen():
	get_node("SamplePlayer2D").play("star_pass_by_1")
