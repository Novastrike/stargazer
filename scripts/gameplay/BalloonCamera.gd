extends Camera2D

export var debug = false

onready var tween = get_node("Tween")

func _ready():
	if debug:
		fix_camera()
	else:
		set_fixed_process(true)

func _fixed_process(delta):
	fix_camera()

func fix_camera():
	var balloon = get_balloon_node()
	if balloon:
		var end = balloon.get_global_pos() - Vector2(OS.get_window_size().width/2, OS.get_window_size().height/2)
		tween.interpolate_method(self, 'set_global_pos', get_global_pos(), end, .2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()

func get_balloon_node():
	var balloons = get_tree().get_nodes_in_group('balloon')
	if balloons.size() > 0:
		return balloons[0]
	return null
