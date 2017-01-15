extends Node2D


func _ready():
	# TODO: Fix mask/layer after explosion signal
	var balloons = get_tree().get_nodes_in_group('balloon-body')
	var random_balloon = int(rand_range(0, balloons.size()))
	balloons[random_balloon].set_collision_mask(2)
	balloons[random_balloon].set_layer_mask(2)
	balloons[random_balloon].set_z(balloons[random_balloon].get_z()+1)
