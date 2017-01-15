tool
extends RigidBody2D

signal explode

export(Color) var modulate = Color(1, 1, 1) setget _set_sprite_modulate
export(bool) var debug = false

onready var anime = get_node('AnimationPlayer')
var speed = 600


func _ready():
	set_fixed_process(true)

func _set_sprite_modulate(color):
	if has_node("Balloon"):
		modulate = color
		get_node("Balloon").set_modulate(modulate)


func _fixed_process(delta):
	var movement = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		movement.x = 1
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1
	var offset = Vector2(1,0)
	var impulse = movement * Vector2(speed * delta, 0)
	apply_impulse(offset, impulse)


func explode():
	anime.play("explode")


func _on_Area2D_body_enter( body ):
	if 'star' in body.get_groups():
		print('Star collision')
		body.explode()
		explode()

func _on_AnimationPlayer_finished():
	if anime.get_current_animation() == 'explode':
		if not debug:
			emit_signal('explode')
			queue_free()
