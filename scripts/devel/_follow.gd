extends KinematicBody2D

export(NodePath) var eject

func _ready():
	set_process_input(true)

func _input(event):
	
	if event.type == InputEvent.MOUSE_MOTION:
		print('mouse move')
		set_pos(event.pos)
	elif event.type == InputEvent.MOUSE_BUTTON:
		print('mouse click')
		if get_node(eject):
			get_node(eject).queue_free()
