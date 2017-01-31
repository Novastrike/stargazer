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
extends Label

export(int) var value = 0 setget _update_value
export(bool) var show_zero = false
export(String) var prefix = ''
export(String) var suffix = ''
export(bool) var enable_sfx = true
export(String) var sfx_name = ''

onready var tween = get_node("Tween")
var init = false
var _value = -1

func _ready():
	update_value()
	init = true

func _update_value(val):
	value = int(val)
	update_value()

func update_value():
	if value != _value:
		_value = value
		if enable_sfx and has_node("Sfx") and init:
			get_node("Sfx").play(sfx_name)
		
	if value == 0 and not show_zero:
		set_text('')
	else:
		set_text(prefix + str(value) + suffix)

func interpolate_from_to(from, to):
	tween.interpolate_property(self, 'value', from, to, 1, 0, 0)
	tween.start()

func interpolate_to(val):
	interpolate_from_to(value, val)

func add(val):
	interpolate_from_to(value, value+val)
	
func sub(val):
	interpolate_from_to(value, value-val)

