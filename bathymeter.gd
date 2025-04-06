extends Node2D

class_name Bathymeter

@onready var long_hand: Sprite2D = $LongHand
@onready var short_hand: Sprite2D = $ShortHand

var value_long:float
var value_short:float
@export var depth:float :
	get:
		return _depth
	set(val):
		_depth = val
		update_hands()
		changed.emit(val)
		
var _depth:float

signal changed

func update_hands():
	if !long_hand or !short_hand:
		return
	long_hand.rotation = depth/10*2*PI
	short_hand.rotation = depth/100*2*PI
