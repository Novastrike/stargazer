extends Node2D

var random_balloon

func _ready():
	var balloons = get_tree().get_nodes_in_group('balloon-body')
	randomize()
	random_balloon = balloons[int(rand_range(0, balloons.size()))]
	random_balloon.add_to_group('front-balloon')
	random_balloon.set_collision_mask(2)
	random_balloon.set_layer_mask(2)
	random_balloon.set_z(random_balloon.get_z()+1)
	
	for balloon in balloons:
		if not 'front-balloon' in balloon.get_groups():
			balloon.connect('explode', self, '_on_balloon_explode')

func _on_balloon_explode():
	var front_balloon = get_tree().get_nodes_in_group('front-balloon')
	if front_balloon.size() > 0:
		front_balloon[0].set_collision_mask(1)
		front_balloon[0].set_layer_mask(1)
