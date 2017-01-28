extends Node2D

signal end(next)

export(bool) var end = false setget _set_end
export(String, FILE, '*.tscn') var next_scene

func _ready():
	pass

func _set_end(val):
	end = val
	if end:
		emit_signal('end', next_scene)