tool
extends Label

export(int) var value = 0 setget _update_value
export(bool) var show_zero = false
export(String) var prefix = ''
export(String) var suffix = ''

onready var tween = get_node("Tween")

func _ready():
	pass

func _update_value(val):
	value = int(val)
	if value == 0 and not show_zero:
		set_text('')
	else:
		set_text(prefix + str(value) + suffix)
		

func interpolate_from_to(from, to):
	tween.interpolate_property(self, 'value', from, to, 1, 0, 0)
	tween.start()

func add(val):
	interpolate_from_to(value, value+val)