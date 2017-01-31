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

tool
extends RigidBody2D

signal explode

export(Color) var modulate = Color(1, 1, 1) setget _set_sprite_modulate
export(bool) var random_color = true
export(Array) var color_list = []
export(bool) var debug = false
export(bool) var debug_explode = false

onready var anime = get_node('AnimationPlayer')


func _ready():
	if random_color:
		randomize()
		_set_sprite_modulate(color_list[rand_range(0, color_list.size())])

func _set_sprite_modulate(color):
	if has_node("Balloon"):
		modulate = color
		get_node("Balloon").set_modulate(modulate)
	if has_node("Particles2D"):
		get_node("Particles2D").set_color(modulate)


func explode():
	anime.play("explode")


func _on_Area2D_body_enter( body ):
	if 'star' in body.get_groups():
		print('Star collision')
		body.explode()
		explode()

func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		if not debug or debug_explode:
			emit_signal('explode')
			queue_free()


func _on_Area2D_mouse_enter():
	if debug_explode:
		print('MOUSE ENTER')
		explode()
