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
TiledSky is an infinite background system to dynamic generate the background.
This system uses the TileMap node to test the TileMap performance.
"""

export(String) var target_group = 'balloon-player'
export(int) var offset = 2
var current_tile = 0
var last_center

func _ready():
	fill_current_tiles()
	set_fixed_process(true)

func _fixed_process(delta):
	fill_current_tiles()

func get_current_tiles():
	var current_tiles = {}
	for tile in get_used_cells():
		current_tiles[tile] = get_cellv(tile)
	return current_tiles


func fill_current_tiles():
	"""Clear and generate the sky tiles."""
	var balloons = get_tree().get_nodes_in_group(target_group)
	if balloons.size() > 0:
		var center = world_to_map(balloons[0].get_global_pos())
		if last_center == center:
			return
		
		var current_tiles = get_current_tiles()
		last_center = center
		
		clear()
		for x in range(center.x-offset, center.x+offset+1):
			for y in range(center.y-offset, center.y+offset+1):
				if Vector2(x, y) in current_tiles:
					set_cell(x, y, current_tiles[Vector2(x, y)])
					continue
				set_cell(x, y, current_tile)


func fill_random_tiles():
	"""Clear and generate the sky tiles."""
	var balloons = get_tree().get_nodes_in_group(target_group)
	if balloons.size() > 0:
		var center = world_to_map(balloons[0].get_global_pos())
		if last_center == center:
			return
		
		var current_tiles = get_current_tiles()
		last_center = center
		
		clear()
		for x in range(center.x-offset, center.x+offset+1):
			for y in range(center.y-offset, center.y+offset+1):
				if Vector2(x, y) in current_tiles:
					set_cell(x, y, current_tiles[Vector2(x, y)])
					continue
				randomize()
				set_cell(x, y, rand_range(0, get_tileset().get_tiles_ids().size()))
