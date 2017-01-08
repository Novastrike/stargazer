extends RigidBody2D


func _ready():
	pass


func _on_GotchaArea_body_enter( body ):
	if 'star' in body.get_groups():
		body.gotcha()
