# MIT License
#
# Copyright (c) 2017 NovastrikeMEDIA
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends Node2D

signal game_over

func _ready():
	print(OS.get_cmdline_args())
	get_node("MainLayer/BalloonPlayer").connect("no_player", self, '_on_BalloonPlayer_no_player')
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_left"):
		print('START GAEM')
		start_game()
		set_process(false)

func start_game():
	get_node("MainLayer/BalloonPlayer").unlock()
	get_node("AnimationPlayer").play("start_game")

func _on_AnimationPlayer_finished():
	if get_node("HUD/GameHUD/AnimationPlayer").get_current_animation() == 'start':
		get_node("MainLayer/SpawnerTimer").start()

func _on_BalloonPlayer_no_player():
	emit_signal('game_over')

