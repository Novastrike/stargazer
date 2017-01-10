extends Camera2D

export var debug = false

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
	fix_y_offset()

func fix_y_offset():
	set_offset(Vector2(0, (INITIAL_V_OFFSET * OS.get_window_size().height)/INITIAL_Y * 1.2))

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
