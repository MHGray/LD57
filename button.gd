extends Area2D

class_name Btn

@export var selected:bool = false
@onready var sprite: AnimatedSprite2D = $Sprite

signal released
signal pressed

func _ready() -> void:
	sprite.animation = "up"

func _process(delta: float) -> void:
	if selected:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			selected = false
			sprite.animation = "up"
			Maestro.play("button_out")
			released.emit()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		selected = true
		Maestro.play("button_in")
		sprite.animation = "down"
		pressed.emit()

func _on_mouse_exited() -> void:
	selected = false
	sprite.animation = "up"
