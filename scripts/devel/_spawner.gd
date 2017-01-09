extends Node2D


func _ready():
	pass


func _on_BalloonBody_explode():
	get_node("AnimationPlayer").play("died")
