extends RigidBody2D

signal explode
signal gotcha

onready var anime = get_node('AnimationPlayer')

func _ready():
	pass

func explode():
	anime.play("explode")

func gotcha():
	anime.play("gotcha")


func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		emit_signal('explode')
	elif anime.get_current_animation() == 'gotcha':
		emit_signal('gotcha')
