"""
MIT License

Copyright (c) 2017 NovastrikeMEDIA

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

extends Node

var combo_multiplier
var colected_stars
var total_score
var temp_total
var temp_combo
var combo_enabled
var score_handler

func _ready():
	reset_score()


func set_score_handler(node):
	score_handler = node

func reset_score():
	combo_multiplier = 0
	colected_stars = [0, 0]
	total_score = 0
	temp_total = 0
	temp_combo = 0
	combo_enabled = false

func increment_combo():
	combo_multiplier += 1
	score_handler.handle_combo_up(combo_multiplier)
	
func combo_break():
	print('TOTAL: ', total_score)
	if combo_multiplier > 1:
		total_score = temp_combo * combo_multiplier + temp_total
		print('TOTAL: ', total_score)
		score_handler.handle_combo_break(total_score)
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
	score_handler.handle_score_up(total_score)
	print('TEMP_COMBO', temp_combo)

