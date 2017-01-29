extends TextureButton

var times = 0

func _ready():
	grab_focus()

func _on_TextureButton_pressed():
	times += 1
	if times == 1:
		get_node("AnimationPlayer").play("show")
		print('Press again to back to title screen')
	if times > 1:
		get_node("AnimationPlayer").play("hide")
		print('Back')
