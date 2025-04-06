extends Node2D

class_name Wheel

@onready var area_2d: Area2D = $Area2D
var selected:bool = false
var rotation_since_last_sfx:float = 0
@export var max_rotation_til_sfx:float = 2*PI
@export var min_rotation_til_sfx:float = PI
var rotation_til_next_sfx:float = 0.5
@export var max_rotation_speed:float = PI+.2 # 90

signal turned(amount_rad:float)
signal grabbed
signal released

func _process(delta: float) -> void:
	if selected:
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			selected = false
			released.emit()
			return
		var prev_rotation = rotation
		look_at(get_global_mouse_position())
		var new_rotation = rotation
		var max_rot = (max_rotation_speed - randf_range(0,PI)) * delta
		if prev_rotation > new_rotation:
			rotation = prev_rotation - min(-new_rotation + prev_rotation, max_rot)
		else:
			rotation = prev_rotation + min(new_rotation - prev_rotation, max_rot)
		if rotation != prev_rotation:
			turned.emit(rotation - prev_rotation)
		rotation_since_last_sfx += abs(rotation - prev_rotation)
		
		if rotation_since_last_sfx >= rotation_til_next_sfx:
			Maestro.play("wheel_ee", 0.2)
			rotation_til_next_sfx = randf_range(min_rotation_til_sfx,max_rotation_til_sfx)
			rotation_since_last_sfx = 0.0

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		selected = true
		grabbed.emit()
