extends Node2D

class_name Toggle

var selected
@onready var sprite: AnimatedSprite2D = $Sprite

@export var value:bool = false

signal pressed
signal released
signal toggled(val:bool)

func _ready() -> void:
	sprite.animation = "up" if value else "down"

func _process(delta: float) -> void:
	if selected:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			selected = false
			released.emit()
		

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		selected = true
		Maestro.play("button_in")
		value = !value
		sprite.animation = "up" if value else "down"
		pressed.emit()
		toggled.emit(value)
