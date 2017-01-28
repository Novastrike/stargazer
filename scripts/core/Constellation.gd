extends Path2D

export(PackedScene) var star

func _ready():
	render_stars()

func render_stars():
	for idx in range(get_curve().get_point_count()):
		var star_node = star.instance()
		add_child(star_node)
		star_node.set_pos(get_curve().get_point_pos(idx))
		print(get_curve().get_point_pos(idx))