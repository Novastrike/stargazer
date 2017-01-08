extends Camera2D


func _ready():
	print(get_balloon_node())
	set_fixed_process(true)

func _fixed_process(delta):
	var balloon = get_balloon_node()
	if balloon:
		# TODO: Add Tween
		set_pos(balloon.get_pos())

func get_balloon_node():
	var balloons = get_tree().get_nodes_in_group('balloon')
	if balloons.size() > 0:
		return balloons[0]
	return null
