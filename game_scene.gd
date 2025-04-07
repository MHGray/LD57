extends Node2D

var turn_speed:float = PI/8
@onready var player: RigidBody3D = $SubViewportContainer/SubViewport/Reality/Player
const SETTINGS = preload("res://settings.tscn")
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport
@onready var sub_viewport_container: Sprite2D = $SubViewportContainer

func _ready() -> void:
	Maestro.play_music("milk")


func _on_settings_btn_pressed() -> void:
	var settings = SETTINGS.instantiate()
	add_child(settings)


func _on_area_3d_body_entered(body: Node3D) -> void:
	print_rich("[wave amp=50][rainbow]UH OH[/rainbow][/wave]")
	sub_viewport.size *= 2
	sub_viewport_container.scale /=2
	$SubViewportContainer/SubViewport/Reality/Node3D2/Area3D.set_deferred("monitoring" , false)
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		get_tree().current_scene.add_child(SETTINGS.instantiate())
