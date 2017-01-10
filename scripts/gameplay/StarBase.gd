extends RigidBody2D

signal explode
signal gotcha
signal out_of_screen
signal destruct(node)

var instance_count = 0
var anime

func _ready():
	anime = get_node('AnimationPlayer')
	set_fixed_process(true)

func _fixed_process(delta):
	var cameras = get_tree().get_nodes_in_group('camera')
	if cameras.size() > 0:
		if abs(cameras[0].get_global_pos().y - get_global_pos().y) >= cameras[0].get_zoom().y * get_viewport().get_rect().size.height+50:
			print('Out of screen')
			emit_signal('out_of_screen')
			destruct()

func reset():
	instance_count += 1
	print(instance_count)
	get_node('AnimationPlayer').play("reset")

func destruct():
	emit_signal('destruct', self)

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
