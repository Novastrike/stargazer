# TODO: Remove movement code

tool
extends RigidBody2D

signal explode

export(Color) var modulate = Color(1, 1, 1) setget _set_sprite_modulate
export(bool) var debug = false
export(bool) var debug_explode = false

onready var anime = get_node('AnimationPlayer')
var speed = 600


func _ready():
	pass

func _set_sprite_modulate(color):
	if has_node("Balloon"):
		modulate = color
		get_node("Balloon").set_modulate(modulate)


func explode():
	anime.play("explode")


func _on_Area2D_body_enter( body ):
	if 'star' in body.get_groups():
		print('Star collision')
		body.explode()
		explode()

func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		if not debug or debug_explode:
			emit_signal('explode')
			queue_free()


func _on_Area2D_mouse_enter():
	if debug_explode:
		print('MOUSE ENTER')
		explode()
