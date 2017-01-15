extends Node2D

var random_balloon

func _ready():
	var balloons = get_tree().get_nodes_in_group('balloon-body')
	randomize()
	random_balloon = balloons[int(rand_range(0, balloons.size()))]
	random_balloon.set_collision_mask(2)
	random_balloon.set_layer_mask(2)
	random_balloon.set_z(random_balloon.get_z()+1)
	
	for balloon in balloons:
		if balloon != random_balloon:
			balloon.connect('explode', self, '_on_balloon_explode')
	

func _on_balloon_explode():
	if random_balloon != null:
		random_balloon.set_collision_mask(1)
		random_balloon.set_layer_mask(1)
