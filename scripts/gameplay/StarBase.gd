extends RigidBody2D

signal explode
signal gotcha
signal out_of_screen

onready var anime = get_node('AnimationPlayer')

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var cameras = get_tree().get_nodes_in_group('camera')
	if cameras.size() > 0:
		if abs(cameras[0].get_global_pos().y - get_global_pos().y) >= OS.get_window_size().height+50:
			print('Out of screen')
			emit_signal('out_of_screen')
			destruct()

func destruct():
	get_parent().queue_free()

func explode():
	anime.play("explode")

func gotcha():
	anime.play("gotcha")


func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		emit_signal('explode')
		destruct()
	elif anime.get_current_animation() == 'gotcha':
		emit_signal('gotcha')
		destruct()
