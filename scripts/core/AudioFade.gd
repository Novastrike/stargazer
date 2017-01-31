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

tool
extends StreamPlayer

export(float) var fade_time = 1
export(bool) var fadein = false setget _set_fadein
export(bool) var fadeout = false setget _set_fadeout


func _ready():
	set_volume(0)

func _set_fadein(val):
	fadein = val
	if fadein:
		var tween = get_node("Tween")
		tween.interpolate_method(self, 'set_volume', 0, 1, fade_time, 0, 0)
		tween.start()
		yield(tween, 'tween_complete')
		fadein = false

func _set_fadeout(val):
	fadeout = val
	if fadeout:
		var tween = get_node("Tween")
		tween.interpolate_method(self, 'set_volume', 1, 0, fade_time, 0, 0)
		tween.start()
		yield(tween, 'tween_complete')
		fadeout = false
