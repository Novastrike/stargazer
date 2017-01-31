tool
extends StreamPlayer

export(float) var fade_time = 1
export(bool) var fadein = false setget _set_fadein
export(bool) var fadeout = false setget _set_fadeout


func _ready():
	set_volume(0)

func _set_fadein(val):
	fadein = val
	if fadein:
		var tween = get_node("Tween")
		tween.interpolate_method(self, 'set_volume', 0, 1, fade_time, 0, 0)
		tween.start()
		yield(tween, 'tween_complete')
		fadein = false

func _set_fadeout(val):
	fadeout = val
	if fadeout:
		var tween = get_node("Tween")
		tween.interpolate_method(self, 'set_volume', 1, 0, fade_time, 0, 0)
		tween.start()
		yield(tween, 'tween_complete')
		fadeout = false
