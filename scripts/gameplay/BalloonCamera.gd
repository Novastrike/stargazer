extends Camera2D

var test_width = 480
var test_height = 640


func _ready():
	#set_offset(Vector2(test_width/2, test_height/2))
	set_fixed_process(true)

func _fixed_process(delta):
	var balloon = get_balloon_node()
	if balloon:
		# TODO: Add Tween
		set_global_pos(balloon.get_global_pos() - Vector2(test_width/2, test_height/2))

func get_balloon_node():
	var balloons = get_tree().get_nodes_in_group('balloon')
	if balloons.size() > 0:
		return balloons[0]
	return null
