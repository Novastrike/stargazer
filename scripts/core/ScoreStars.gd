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

extends Node2D

export var constellations = []
export(PackedScene) var constellation_base
export var debug = false
export var debug_stars = [0, 0]
var star_points = 0

func _ready():
	constellations.sort_custom(self, 'sort_constellations')
	star_points += Score.colected_stars[0]
	star_points += Score.colected_stars[1] * 2
	render_constellations()

func render_constellations():
	if debug:
		star_points += debug_stars[0]
		star_points += debug_stars[1] * 2
	
	randomize()
	for constellation in constellations:
		if constellation.get_point_count() <= star_points:
			star_points -= constellation.get_point_count()
			var constellation_node = constellation_base.instance()
			add_child(constellation_node)
			var x = rand_range(0, get_viewport_rect().size.x/1.5)
			var y = rand_range(0, get_viewport_rect().size.y/1.5)
			constellation_node.set_pos(Vector2(x, y))
			constellation_node.set_curve(constellation)
			constellation_node.render_stars()

func sort_constellations(obj1, obj2):
	return obj1.get_point_count() < obj2.get_point_count()
	