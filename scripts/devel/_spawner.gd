extends Node2D

export(PackedScene) var star

export var testing = true
var star_name

func _ready():
	pass

func spawn_star():
	var star_node
	var spawners = get_tree().get_nodes_in_group('spawner-area')
	if spawners.size() > 0:
		if Pool.has_objects('stars'):
			star_node = Pool.get_object('stars')
			star_node.set_name(star_name)
			spawners[0].spawn_random(star_node)
		else:
			star_node = star.instance()
			star_name = star_node.get_name()
			spawners[0].spawn_random(star_node)
		print(star_node.get_name())

func _on_Timer_timeout():
	if testing:
		spawn_star()

func _on_BalloonBody_explode():
	get_node("AnimationPlayer").play("died")
