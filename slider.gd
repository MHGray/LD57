extends Node2D

class_name Throttle

@onready var knob: Area2D = $Knob
@onready var max_marker: Marker2D = $MaxMarker
@onready var min_marker: Marker2D = $MinMarker
@onready var looker: Marker2D = $Knob/Looker
var dir_to_max:Vector2

var selected:bool = false
var value:float = 0
var percent:float = 0
@export var value_min:float = 0
@export var value_max:float = 100
@export var min_slide_speed:float = .01
@export var max_slide_speed:float = .75 # Value per second
var slide_speed:float
var slide_speed_change_time:float
@export var slide_speed_change_time_min:float = .2
@export var slide_speed_change_time_max:float = .5

signal changed(value:float)
signal grabbed
signal released

func _ready() -> void:
	value = value_min
	knob.position = min_marker.position
	dir_to_max = knob.position.direction_to(max_marker.position)

func _process(delta: float) -> void:
	if !selected:
		return
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		selected = false
		released.emit()
	looker.look_at(get_global_mouse_position())
	var direction_to_mouse: = -sin(looker.rotation)
	slide_speed_change_time -= delta
	if slide_speed_change_time <= 0:
		slide_speed = randf_range(min_slide_speed,max_slide_speed)
		slide_speed_change_time = randf_range(slide_speed_change_time_min,slide_speed_change_time_max)
	#var resistance = randf_range() * direction_to_mouse
	percent += slide_speed * direction_to_mouse * delta
	percent = clamp(percent,0,1)
	var new_pos = lerp(min_marker.position,max_marker.position,percent)
	knob.position = new_pos
	value = abs(value_max - value_min) * percent + value_min
	changed.emit(value)

func _on_knob_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		selected = true
		grabbed.emit()
