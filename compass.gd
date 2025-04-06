extends Node2D

class_name Compass

@export var heading:float :
	get:
		return _heading
	set(val):
		_heading = val
		update_display()
		changed.emit(val)
@onready var compass_strip: Sprite2D = $CompassStrip

		
var _heading:float
var amount_to_next_ordinal:float = 32

signal changed

func _ready() -> void:
	heading = 0

func update_display():
	if !compass_strip:return
	compass_strip.region_rect.position.x = heading * 128 / 2 / PI
	if heading > 2*PI:
		heading -= 2*PI
	if heading < 0:
		heading += 2*PI
