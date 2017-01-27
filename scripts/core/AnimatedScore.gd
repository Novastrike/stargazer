tool
extends Label

export(int) var value = 0 setget _update_value
export(bool) var show_zero = false
export(String) var prefix = ''
export(String) var suffix = ''
export(bool) var enable_sfx = true
export(String) var sfx_name = ''

onready var tween = get_node("Tween")

func _ready():
	pass

func _update_value(val):
	value = int(val)
	update_value()

func update_value():
	if value == 0 and not show_zero:
		set_text('')
	else:
		set_text(prefix + str(value) + suffix)
		
	if enable_sfx:
		get_node("Sfx").play(sfx_name)

func interpolate_from_to(from, to):
	tween.interpolate_property(self, 'value', from, to, 1, 0, 0)
	tween.start()

func add(val):
	interpolate_from_to(value, value+val)
	
func sub(val):
	interpolate_from_to(value, value-val)
	
