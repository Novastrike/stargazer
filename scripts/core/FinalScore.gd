extends Label


func _ready():
	set_text('Final score: '+ str(Score.total_score))
