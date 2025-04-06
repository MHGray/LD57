extends Node2D

class_name Indicator

@onready var sprite: AnimatedSprite2D = $Sprite

enum VALUE{
	RED,YELLOW,GREEN
}

var value:VALUE : 
	get: 
		return _value
	set(val):
		_value = val
		changed.emit(value)

var _value:VALUE

signal changed(color:VALUE)

func _ready() -> void:
	_value = VALUE.RED
	change_color(value)
	changed.connect(change_color)

func _on_changed(_unused) -> void:
	change_color(value)

func change_color(val:VALUE) -> void:
	match val:
		VALUE.RED:
			sprite.animation = "red"
		VALUE.YELLOW:
			sprite.animation = "yellow"
		VALUE.GREEN:
			sprite.animation = "green"
