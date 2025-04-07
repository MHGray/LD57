extends Node2D

const SETTINGS = preload("res://settings.tscn")

func _on_test_btn_pressed() -> void:
	Maestro.play_voice("shave")
	pass # Replace with function body.


func _on_settings_btn_pressed() -> void:
	var settings = SETTINGS.instantiate()
	add_child(settings)

	pass # Replace with function body


func _on_play_game_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://game_scene.tscn")
	pass # Replace with function body.
