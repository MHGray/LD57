extends Node2D

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var num_frames:int
const GAME_OVER = preload("res://game_over.tscn")
func _ready() -> void:
	num_frames = animated_sprite_2d.sprite_frames.get_frame_count("default")
	timer.timeout.connect(end_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var percent_done = 1 - timer.time_left/timer.wait_time
	var time_to_change = floor(num_frames*percent_done) > animated_sprite_2d.frame
	if time_to_change:
		if animated_sprite_2d.frame +1 > num_frames:
			return
		animated_sprite_2d.frame +=1

func end_game():
	get_tree().change_scene_to_packed(GAME_OVER)
