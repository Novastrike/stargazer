extends Control


func _ready():
	Score.set_score_handler(self)

func handle_score_up(score):
	get_node("Score").interpolate_to(score)

func handle_combo_up(combo):
	if combo > 1:
		get_node("Combo").interpolate_to(combo)

func handle_combo_break(score):
	get_node("Combo").interpolate_to(0)
	get_node("Score").interpolate_to(score)
