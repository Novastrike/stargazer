extends Node


func _ready():
	pass


func _on_TitleScreen_game_over():
	get_parent().end = true
