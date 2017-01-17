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

extends TileMap

"""
TiledSky is aa infinite background system to dynamic generate the background.
This system uses the TileMap node to test the TileMap performance.
"""

export(String) var target_group = 'balloon-player'
export(int) var offset = 2
var current_tile = 0
var last_center

func _ready():
	fill_tiles()
	set_fixed_process(true)

func _fixed_process(delta):
	fill_tiles()

func fill_tiles():
	"""Clear and generate the sky tiles."""
	
	var balloons = get_tree().get_nodes_in_group(target_group)
	if balloons.size() > 0:
		var center = world_to_map(balloons[0].get_global_pos())
		if last_center == center:
			return
		
		last_center = center
		var centerx = center.x
		var centery = center.y
		# TODO: Improve clear method
		clear()
		for x in range(centerx-offset, centerx+offset+1):
			for y in range(centery-offset, centery+offset+1):
				#print('ADD TILE TO: ', x, ', ', y)
				set_cell(x, y, current_tile)
