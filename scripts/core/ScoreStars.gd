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
	print(Score.colected_stars)
	if debug:
		star_points += debug_stars[0]
		star_points += debug_stars[1] * 2
	
	print(star_points)
	for constellation in constellations:
		if constellation.get_point_count() <= star_points:
			star_points -= constellation.get_point_count()
			var constellation_node = constellation_base.instance()
			add_child(constellation_node)
			constellation_node.set_curve(constellation)
			constellation_node.render_stars()

func sort_constellations(obj1, obj2):
	return obj1.get_point_count() < obj2.get_point_count()
	