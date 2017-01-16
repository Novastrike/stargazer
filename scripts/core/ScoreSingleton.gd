extends Node

var combo_multiplier
var colected_stars
var total_score
var temp_total
var temp_combo
var combo_enabled

func _ready():
	reset_score()

func reset_score():
	combo_multiplier = 0
	colected_stars = [0, 0]
	total_score = 0
	temp_total = 0
	temp_combo = 0
	combo_enabled = false

func increment_combo():
	combo_multiplier += 1
	
func combo_break():
	print('TOTAL: ', total_score)
	if combo_multiplier > 1:
		total_score = temp_combo * combo_multiplier + temp_total
		print('TOTAL: ', total_score)
	combo_multiplier = 0
	temp_combo = 0
	temp_total = 0

func push_star(type, points):
	colected_stars[type] += 1
	if combo_multiplier == 0:
		temp_total = total_score
	increment_combo()
	total_score += points
	temp_combo += points
	print('TOTAL: ', total_score)
	print('TEMP_COMBO', temp_combo)

