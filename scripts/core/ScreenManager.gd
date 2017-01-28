extends Node2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func change_scene(scene_path):
	remove_child(get_child(0))
	var next_scene = load(scene_path).instance()
	next_scene.connect('end', self, '_on_scene_end')

func _on_scene_end(next):
	change_scene(next)

