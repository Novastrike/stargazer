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

# TODO: Add relative zoom method

extends Camera2D

export(String) var target_group = 'balloon-player'
export(bool) var smooth = true
export(bool) var debug = false

onready var tween = get_node("Tween")
onready var INITIAL_V_OFFSET = get_offset().y
const INITIAL_Y = 640

func _ready():
	if debug:
		fix_camera()
	else:
		set_fixed_process(true)

func _fixed_process(delta):
	fix_camera()
	fix_v_offset()

func fix_v_offset():
	set_offset(Vector2(0, (INITIAL_V_OFFSET * get_viewport().get_rect().size.height * get_zoom().y)/INITIAL_Y * 1.2))

func fix_camera():
	var balloon = get_balloon_node()
	if balloon:
		var viewport_size = get_viewport().get_rect().size
		var end = balloon.get_global_pos() - Vector2(viewport_size.width/2 * get_zoom().x, viewport_size.height/2 * get_zoom().y)
		if smooth:
			tween.interpolate_method(self, 'set_global_pos', get_global_pos(), end, .2, Tween.TRANS_LINEAR, Tween.EASE_IN)
			tween.start()
		else:
			set_global_pos(end)

func get_balloon_node():
	var balloons = get_tree().get_nodes_in_group(target_group)
	if balloons.size() > 0:
		return balloons[0]
	return null
