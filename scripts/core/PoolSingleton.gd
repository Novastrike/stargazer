extends Node

var pools = {
	'stars': [] # NOTE: REMOVE BEFORE RELEASE
}

func _ready():
	pass

func create_pool(name):
	if not name in pools:
		pools[name] = []

func has_objects(pool):
	if pool in pools:
		return pools[pool].size() > 0
	return false

func push_object(object, pool):
	pools[pool].append(object)

func get_object(pool):
	var object = pools[pool][0]
	pools[pool].pop_front()
	return object
