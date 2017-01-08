extends Node

var pools = {
	'stars': []
}

func _ready():
	pass

func has_objects(pool):
	return pools[pool].size() > 0

func push_object(object, pool):
	pools[pool].append(object)

func get_object(pool):
	var object = pools[pool][0]
	pools[pool].pop_front()
	return object
